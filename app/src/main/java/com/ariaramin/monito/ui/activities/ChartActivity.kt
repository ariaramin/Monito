package com.ariaramin.monito.ui.activities

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
import com.ariaramin.monito.ViewModels.CategoryViewModel
import com.ariaramin.monito.ViewModels.CategoryViewModelFactory
import com.ariaramin.monito.ViewModels.TransactionViewModel
import com.ariaramin.monito.ViewModels.TransactionViewModelFactory


class ChartActivity : AppCompatActivity() {

    private lateinit var transactionViewModel: TransactionViewModel
    private lateinit var categoryViewModel: CategoryViewModel
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
        recyclerView = findViewById<RecyclerView>(R.id.categoryPercentageRecyclerView)

        adapter = CategoryPercentageAdapter()
        val database = AppDatabase.getInstance(applicationContext)
        val categoryRepository = CategoryRepository(database)
        val categoryFactory = CategoryViewModelFactory(categoryRepository)
        categoryViewModel =
            ViewModelProvider(this, categoryFactory).get(CategoryViewModel::class.java)
        categoryViewModel.getExpenseCategories().observe(this,
            { categories ->
                transactionViewModel.getAllTransactions().observe(this,
                    { transactions ->
                        getCategoryPercentage(categories, transactions)
                    }
                )
            })
        val transactionRepository = TransactionRepository(database)
        val transactionFactory = TransactionViewModelFactory(transactionRepository)
        transactionViewModel =
            ViewModelProvider(this, transactionFactory).get(TransactionViewModel::class.java)

    }

    private fun getCategoryPercentage(items: List<Category>, list: List<Transaction>) {
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
        adapter!!.addCategoryHashMap(categoryPercentage)
        recyclerView!!.layoutManager = LinearLayoutManager(applicationContext)
        recyclerView!!.adapter = adapter
    }
}