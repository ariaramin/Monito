package com.ariaramin.monito.Repositories

import com.ariaramin.monito.Database.AppDatabase
import com.ariaramin.monito.Models.Category

class CategoryRepository(private val db: AppDatabase) {

    fun insertCategory(category: Category) = db.getCategoryDao().addCategory(category)

    fun getAllCategories() = db.getCategoryDao().getAllCategories()

    fun getIncomeCategories() = db.getCategoryDao().getIncomeCategories()

    fun getExpenseCategories() = db.getCategoryDao().getExpenseCategories()
}