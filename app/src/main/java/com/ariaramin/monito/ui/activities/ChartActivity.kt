package com.ariaramin.monito.ui.activities

import android.graphics.Color
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageView
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.ariaramin.monito.Adapters.CategoryPercentageAdapter
import com.ariaramin.monito.Database.AppDatabase
import com.ariaramin.monito.Models.Category
import com.ariaramin.monito.Models.Transaction
import com.ariaramin.monito.R
import com.ariaramin.monito.Repositories.CategoryRepository
import com.ariaramin.monito.Repositories.TransactionRepository
import com.ariaramin.monito.Utils.Utils
import com.ariaramin.monito.ViewModels.CategoryViewModel
import com.ariaramin.monito.ViewModels.CategoryViewModelFactory
import com.ariaramin.monito.ViewModels.TransactionViewModel
import com.ariaramin.monito.ViewModels.TransactionViewModelFactory
import com.github.mikephil.charting.charts.PieChart
import com.github.mikephil.charting.data.PieData
import com.github.mikephil.charting.data.PieDataSet
import com.github.mikephil.charting.data.PieEntry
import com.github.mikephil.charting.formatter.PercentFormatter
import com.github.mikephil.charting.utils.ColorTemplate
import com.github.mikephil.charting.animation.Easing
import com.github.mikephil.charting.components.Legend
import com.google.android.material.chip.Chip
import java.util.*
import kotlin.collections.ArrayList
import kotlin.collections.HashMap


class ChartActivity : AppCompatActivity() {

    private lateinit var transactionViewModel: TransactionViewModel
    private lateinit var categoryViewModel: CategoryViewModel
    private var pieChart: PieChart? = null
    private var recyclerView: RecyclerView? = null
    private var adapter: CategoryPercentageAdapter? = null
    private val categoryPercentage: HashMap<Category, String> = HashMap()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_chart)

        val backToHome = findViewById<ImageView>(R.id.backImageView5)
        backToHome.setOnClickListener {
            finish()
        }
        val expenseChip = findViewById<Chip>(R.id.expenseChip)
        val incomeChip = findViewById<Chip>(R.id.incomeChip)
        pieChart = findViewById<PieChart>(R.id.pieChart)
        recyclerView = findViewById<RecyclerView>(R.id.categoryPercentageRecyclerView)
        adapter = CategoryPercentageAdapter()
        recyclerView!!.layoutManager = LinearLayoutManager(applicationContext)
        recyclerView!!.adapter = adapter
        // initializing database
        val database = AppDatabase.getInstance(applicationContext)

        // initializing category view model
        val categoryRepository = CategoryRepository(database)
        val categoryFactory = CategoryViewModelFactory(categoryRepository)
        categoryViewModel =
            ViewModelProvider(this, categoryFactory).get(CategoryViewModel::class.java)

        // initializing transaction view model
        val transactionRepository = TransactionRepository(database)
        val transactionFactory = TransactionViewModelFactory(transactionRepository)
        transactionViewModel =
            ViewModelProvider(this, transactionFactory).get(TransactionViewModel::class.java)

        expenseChip.setOnCheckedChangeListener { buttonView, isChecked ->
            if (isChecked) {
                getExpenses()
            }
        }
        incomeChip.setOnCheckedChangeListener { buttonView, isChecked ->
            if (isChecked) {
                getIncomes()
            }
        }

        getExpenses()
    }

    private fun getExpenses() {
        categoryViewModel.getExpenseCategories().observe(this,
            { categories ->
                transactionViewModel.getAllTransactions().observe(this,
                    { transactions ->
                        val filteredList = transactions.filter { transaction -> transaction.category.type == "expense" }
                        getCategoryPercentage(categories, filteredList)
                        initPieChart()
                        showPieChart(filteredList)
                    }
                )
            })
    }

    private fun getIncomes() {
        categoryViewModel.getIncomeCategories().observe(this,
            { categories ->
                transactionViewModel.getAllTransactions().observe(this,
                    { transactions ->
                        val filteredList = transactions.filter { transaction -> transaction.category.type == "income" }
                        getCategoryPercentage(categories, filteredList)
                        initPieChart()
                        showPieChart(filteredList)
                    }
                )
            })
    }

    private fun getCategoryPercentage(items: List<Category>, list: List<Transaction>) {
        // refresh hashmap
        categoryPercentage.clear()
        if (items.isNotEmpty()) {
            for (category in items) {
                val transactions =
                    list.filter { transaction -> transaction.category.categoryid == category.categoryid }
                val size = transactions.size
                val percentage = (size.toDouble() / list.size) * 100
                categoryPercentage[category] = percentage.toInt().toString()
            }
        }
        adapter!!.addTransactionList(list)
        adapter!!.addCategoryHashMap(sortHashMap(categoryPercentage))
    }

    private fun showPieChart(transactions: List<Transaction>) {
        val utils = Utils()
        val pieEntries: ArrayList<PieEntry> = ArrayList()
        var total = 0

        //initializing colors for the entries
        val colors: ArrayList<Int> = ArrayList()
        for (color in ColorTemplate.MATERIAL_COLORS) {
            colors.add(color)
        }
        for (color in ColorTemplate.COLORFUL_COLORS) {
            colors.add(color)
        }

        //input data and fit data into pie chart entry
        for (category in categoryPercentage.keys) {
            if (categoryPercentage[category]!!.toInt() != 0) {
                pieEntries.add(PieEntry(categoryPercentage[category]!!.toFloat(), category.title))
            }
        }

        if (pieEntries.isEmpty()) {
            pieEntries.add(PieEntry(100f, "خالی"))
        }

        val pieDataSet = PieDataSet(pieEntries, "")
        pieDataSet.valueTextSize = 14f
        if (pieEntries[0].label == "خالی") {
            pieDataSet.setColor(0, Color.DKGRAY)
        } else {
            pieDataSet.colors = colors
            for (item in transactions) {
                if (item.category.type == "income")
                    total += item.amount.toInt() else
                    total -= item.amount.toInt()
            }
        }
        adapter!!.addColorList(pieDataSet.colors)
        val pieData = PieData(pieDataSet)
        pieData.setDrawValues(true)
        pieData.setValueFormatter(PercentFormatter())
        pieChart!!.data = pieData
        if (pieData.entryCount <= 0) {
            pieChart!!.centerText = resources.getString(R.string.no_transaction)
        } else {
            pieChart!!.centerText = "مجموع \n ${utils.convertPersianPrice(total.toString())}"
        }
        pieChart!!.setCenterTextSize(14f)
        pieChart!!.setEntryLabelTextSize(16f)
        pieChart!!.legend.isEnabled = false
//        val legend = pieChart!!.legend
//        legend.horizontalAlignment = Legend.LegendHorizontalAlignment.RIGHT
//        legend.verticalAlignment = Legend.LegendVerticalAlignment.CENTER
//        legend.orientation = Legend.LegendOrientation.VERTICAL
        pieChart!!.invalidate()
    }

    private fun initPieChart() {
        pieChart!!.setUsePercentValues(true)
        pieChart!!.description.isEnabled = false
        pieChart!!.isRotationEnabled = true
        pieChart!!.dragDecelerationFrictionCoef = 0.9f
        pieChart!!.rotationAngle = 0f
        pieChart!!.isHighlightPerTapEnabled = true
        pieChart!!.animateY(1400, Easing.EaseInOutQuad)
    }

    private fun sortHashMap(hashMap: HashMap<Category, String>): HashMap<Category, String> {
        val list = LinkedList<Map.Entry<Category, String>>(hashMap.entries)
        list.sortWith(Comparator { o1, o2 -> (o2!!.value.compareTo(o1!!.value)) })
        val sortedHashMap: HashMap<Category, String> = LinkedHashMap()
        for ((key, value) in list) {
            sortedHashMap[key] = value
        }
        return sortedHashMap
    }

}