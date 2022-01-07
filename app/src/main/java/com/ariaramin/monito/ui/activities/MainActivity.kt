package com.ariaramin.monito.ui.activities

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View.GONE
import android.widget.ImageView
import androidx.core.content.ContextCompat
import androidx.core.graphics.drawable.toBitmap
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.ariaramin.monito.Adapters.GeneralItemAdapter
import com.ariaramin.monito.Adapters.TransactionAdapter
import com.ariaramin.monito.Database.AppDatabase
import com.ariaramin.monito.Dialogs.DialogListener
import com.ariaramin.monito.R
import com.ariaramin.monito.Dialogs.TransactionDialog
import com.ariaramin.monito.Models.*
import com.ariaramin.monito.Repositories.CategoryRepository
import com.ariaramin.monito.Repositories.TransactionRepository
import com.ariaramin.monito.ViewModels.CategoryViewModel
import com.ariaramin.monito.ViewModels.CategoryViewModelFactory
import com.ariaramin.monito.ViewModels.TransactionViewModel
import com.ariaramin.monito.ViewModels.TransactionViewModelFactory
import com.google.android.material.bottomappbar.BottomAppBar
import com.google.android.material.floatingactionbutton.FloatingActionButton


class MainActivity : AppCompatActivity() {

    private lateinit var categoryViewModel: CategoryViewModel
    private lateinit var transactionViewModel: TransactionViewModel
    lateinit var generalItemAdapter: GeneralItemAdapter
    private var backgroundImage: ImageView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

//        backgroundImage = findViewById<ImageView>(R.id.backgroundImageView)

        val database = AppDatabase.getInstance(applicationContext)
        val transactionRepository = TransactionRepository(database)
        val transactionFactory = TransactionViewModelFactory(transactionRepository)
        transactionViewModel =
            ViewModelProvider(this, transactionFactory).get(TransactionViewModel::class.java)

        generalItemAdapter = GeneralItemAdapter(this)
        val layoutManager = LinearLayoutManager(this)
        val recyclerView = findViewById<RecyclerView>(R.id.transactionRecyclerView)
        recyclerView.layoutManager = layoutManager
        recyclerView.adapter = generalItemAdapter
        transactionViewModel.getAllTransactions().observe(this,
            { t ->
                if (generalItemAdapter.itemCount <= 0) {
                    var date = ""
                    var total = 0
                    val dateList: MutableList<DateItem> = ArrayList()
                    val generalItemList: MutableList<GeneralItem> = ArrayList()
                    for (transaction in t) {
                        if (transaction.date != date) {
                            if (total != 0 && date != "") {
                                val dateItem = DateItem(date, total.toString())
                                dateList.add(dateItem)
                            }
                            date = transaction.date
                            if (total != 0) {
                                total = if (transaction.category.type == "income")
                                    transaction.amount.toInt() else
                                    -transaction.amount.toInt()
                            } else {
                                if (transaction.category.type == "income")
                                    total += transaction.amount.toInt() else
                                    total -= transaction.amount.toInt()
                            }
                        } else {
                            if (transaction.category.type == "income")
                                total += transaction.amount.toInt() else
                                total -= transaction.amount.toInt()
                            if (total != 0 && t.last() == transaction) {
                                val dateItem = DateItem(date, total.toString())
                                dateList.add(dateItem)
                            }
                        }
                    }
                    for (dateItem in dateList) {
                        val transactions = t.filter { it -> it.date == dateItem.date }
                        val generalItem = GeneralItem(dateItem, transactions)
                        generalItemList.add(generalItem)
                    }
                    generalItemAdapter.addItemList(generalItemList)
                }
            }
        )

        val categoryRepository = CategoryRepository(database)
        val categoryFactory = CategoryViewModelFactory(categoryRepository)
        categoryViewModel =
            ViewModelProvider(this, categoryFactory).get(CategoryViewModel::class.java)
        categoryViewModel.getIncomeCategories().observe(this, {
            if (it.isEmpty()) {
                insertCategories()
            }
        })

        val bottomAppBar = findViewById<BottomAppBar>(R.id.bottomAppBar)
        bottomAppBar.setOnMenuItemClickListener {
            when (it.itemId) {
                R.id.home -> {

                    true
                }
                R.id.chart -> {
                    true
                }
                R.id.category -> {
                    true
                }
                else -> false
            }
        }

        val fab = findViewById<FloatingActionButton>(R.id.floatingActionButton)
        fab.setOnClickListener {
            val dialog = TransactionDialog()
            dialog.show(supportFragmentManager, null)
        }
    }

    private fun insertCategories() {
        val categoryList = arrayListOf<Category>(
            Category(
                "غذا",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.food)!!.toBitmap()
            ),
            Category(
                "میوه",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.fruit)!!.toBitmap()
            ),
            Category(
                "خرید",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.shopping)!!.toBitmap()
            ),
            Category(
                "پوشاک",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.clothes)!!.toBitmap()
            ),
            Category(
                "کتاب",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.book)!!.toBitmap()
            ),
            Category(
                "قبض",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.bill)!!.toBitmap()
            ),
            Category(
                "ورزش",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.dumbbell)!!.toBitmap()
            ),
            Category(
                "حمل و نقل",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.vehicles)!!.toBitmap()
            ),
            Category(
                "سرگرمی",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.game_controller)!!
                    .toBitmap()
            ),
            Category(
                "حیوان خانگی",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.dog)!!.toBitmap()
            ),
            Category(
                "بیمه",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.insurance)!!.toBitmap()
            ),
            Category(
                "سلامتی",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.healthcare)!!.toBitmap()
            ),
            Category(
                "ماشین",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.car)!!.toBitmap()
            ),
            Category(
                "خانه",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.home)!!.toBitmap()
            ),
            Category(
                "موبایل",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.iphone)!!.toBitmap()
            ),
            Category(
                "تحصیل",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.graduation)!!.toBitmap()
            ),
            Category(
                "قسط",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.taxes)!!.toBitmap()
            ),
            Category(
                "سفر",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.airplane)!!.toBitmap()
            ),
            Category(
                "بچه",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.baby)!!.toBitmap()
            ),
            Category(
                "هدیه",
                "expense",
                ContextCompat.getDrawable(applicationContext, R.drawable.present)!!.toBitmap()
            ),

            Category(
                "حقوق",
                "income",
                ContextCompat.getDrawable(applicationContext, R.drawable.calendar)!!.toBitmap()
            ),
            Category(
                "فروش",
                "income",
                ContextCompat.getDrawable(applicationContext, R.drawable.sale_tag)!!.toBitmap()
            ),
            Category(
                "اجاره",
                "income",
                ContextCompat.getDrawable(applicationContext, R.drawable.house)!!.toBitmap()
            ),
            Category(
                "جایزه",
                "income",
                ContextCompat.getDrawable(applicationContext, R.drawable.medal)!!.toBitmap()
            ),
            Category(
                "سود سهام",
                "income",
                ContextCompat.getDrawable(applicationContext, R.drawable.dividend)!!.toBitmap()
            ),
            Category(
                "سایر",
                "income",
                ContextCompat.getDrawable(applicationContext, R.drawable.more)!!.toBitmap()
            ),
        )

        for (category in categoryList) {
            categoryViewModel.insertCategory(category)
        }
    }
}