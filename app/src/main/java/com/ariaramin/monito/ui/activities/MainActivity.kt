package com.ariaramin.monito.ui.activities

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.core.content.ContextCompat
import androidx.core.graphics.drawable.toBitmap
import androidx.fragment.app.FragmentTransaction
import androidx.lifecycle.ViewModelProvider
import com.ariaramin.monito.Database.AppDatabase
import com.ariaramin.monito.ui.fragments.home.HomeFragment
import com.ariaramin.monito.R
import com.ariaramin.monito.Dialogs.TransactionDialog
import com.ariaramin.monito.Models.Category
import com.ariaramin.monito.Repositories.CategoryRepository
import com.ariaramin.monito.Repositories.TransactionRepository
import com.ariaramin.monito.ViewModels.CategoryViewModel
import com.ariaramin.monito.ViewModels.CategoryViewModelFactory
import com.ariaramin.monito.ViewModels.TransactionViewModel
import com.ariaramin.monito.ViewModels.TransactionViewModelFactory
import com.google.android.material.bottomappbar.BottomAppBar
import com.google.android.material.floatingactionbutton.FloatingActionButton

class MainActivity : AppCompatActivity() {

    private lateinit var viewModel: CategoryViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val fab = findViewById<FloatingActionButton>(R.id.floatingActionButton)
        fab.setOnClickListener {
            val dialog = TransactionDialog()
            dialog.show(supportFragmentManager, null)
        }

        val database = AppDatabase.getInstance(applicationContext)
        val categoryRepository = CategoryRepository(database)
        val factory = CategoryViewModelFactory(categoryRepository)
        viewModel = ViewModelProvider(this, factory).get(CategoryViewModel::class.java)
        viewModel.getIncomeCategories().observe(this, {
            if (it.isEmpty()) {
                insertCategories()
            }
        })

        supportFragmentManager.beginTransaction()
            .replace(R.id.frameLayout, HomeFragment())
            .commit()
        val bottomAppBar = findViewById<BottomAppBar>(R.id.bottomAppBar)
        bottomAppBar.setOnMenuItemClickListener {
            when (it.itemId) {
                R.id.home -> {
                    supportFragmentManager.beginTransaction()
                        .setTransition(FragmentTransaction.TRANSIT_FRAGMENT_FADE)
                        .replace(R.id.frameLayout, HomeFragment())
                        .commit()
                    true
                }
                R.id.chart -> {
                    supportFragmentManager.beginTransaction()
                        .setTransition(FragmentTransaction.TRANSIT_FRAGMENT_FADE)
                        .replace(R.id.frameLayout, HomeFragment())
                        .commit()
                    true
                }
                R.id.category -> {
                    supportFragmentManager.beginTransaction()
                        .setTransition(FragmentTransaction.TRANSIT_FRAGMENT_FADE)
                        .replace(R.id.frameLayout, HomeFragment())
                        .commit()
                    true
                }
                else -> false
            }
        }
    }

    private fun insertCategories() {
        val categoryList = arrayListOf<Category>(
            Category("سایر", "income", ContextCompat.getDrawable(applicationContext, R.drawable.more)!!.toBitmap()),
            Category("غذا", "income", ContextCompat.getDrawable(applicationContext, R.drawable.food)!!.toBitmap()),
            Category("میوه", "income", ContextCompat.getDrawable(applicationContext, R.drawable.fruit)!!.toBitmap()),
            Category("خرید", "income", ContextCompat.getDrawable(applicationContext, R.drawable.shopping)!!.toBitmap()),
            Category("پوشاک", "income", ContextCompat.getDrawable(applicationContext, R.drawable.clothes)!!.toBitmap()),
            Category("کتاب", "income", ContextCompat.getDrawable(applicationContext, R.drawable.book)!!.toBitmap()),
            Category("قبض", "income", ContextCompat.getDrawable(applicationContext, R.drawable.bill)!!.toBitmap()),
            Category("ورزش", "income", ContextCompat.getDrawable(applicationContext, R.drawable.dumbbell)!!.toBitmap()),
            Category("حمل و نقل", "income", ContextCompat.getDrawable(applicationContext, R.drawable.vehicles)!!.toBitmap()),
            Category("سرگرمی", "income", ContextCompat.getDrawable(applicationContext, R.drawable.game_controller)!!.toBitmap()),
            Category("حیوان خانگی", "income", ContextCompat.getDrawable(applicationContext, R.drawable.dog)!!.toBitmap()),
            Category("بیمه", "income", ContextCompat.getDrawable(applicationContext, R.drawable.insurance)!!.toBitmap()),
            Category("سلامتی", "income", ContextCompat.getDrawable(applicationContext, R.drawable.healthcare)!!.toBitmap()),
            Category("ماشین", "income", ContextCompat.getDrawable(applicationContext, R.drawable.car)!!.toBitmap()),
            Category("خانه", "income", ContextCompat.getDrawable(applicationContext, R.drawable.home)!!.toBitmap()),
            Category("موبایل", "income", ContextCompat.getDrawable(applicationContext, R.drawable.iphone)!!.toBitmap()),
            Category("تحصیل", "income", ContextCompat.getDrawable(applicationContext, R.drawable.graduation)!!.toBitmap()),
            Category("قسط", "income", ContextCompat.getDrawable(applicationContext, R.drawable.taxes)!!.toBitmap()),
            Category("سفر", "income", ContextCompat.getDrawable(applicationContext, R.drawable.airplane)!!.toBitmap()),
            Category("بچه", "income", ContextCompat.getDrawable(applicationContext, R.drawable.baby)!!.toBitmap()),
            Category("هدیه", "income", ContextCompat.getDrawable(applicationContext, R.drawable.present)!!.toBitmap()),

            Category("حقوق", "expense", ContextCompat.getDrawable(applicationContext, R.drawable.calendar)!!.toBitmap()),
            Category("فروش", "expense", ContextCompat.getDrawable(applicationContext, R.drawable.sale_tag)!!.toBitmap()),
            Category("اجاره", "expense", ContextCompat.getDrawable(applicationContext, R.drawable.house)!!.toBitmap()),
            Category("جایزه", "expense", ContextCompat.getDrawable(applicationContext, R.drawable.medal)!!.toBitmap()),
            Category("سود سهام", "expense", ContextCompat.getDrawable(applicationContext, R.drawable.dividend)!!.toBitmap())
        )

        for (category in categoryList) {
            viewModel.insertCategory(category)
        }
    }
}