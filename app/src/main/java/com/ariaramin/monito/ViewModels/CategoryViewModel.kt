package com.ariaramin.monito.ViewModels

import androidx.lifecycle.ViewModel
import com.ariaramin.monito.Models.Category
import com.ariaramin.monito.Repositories.CategoryRepository

class CategoryViewModel(private val repository: CategoryRepository) : ViewModel() {

    fun insertCategory(category: Category) = repository.insertCategory(category)

    fun getIncomeCategories() = repository.getIncomeCategories()

    fun getExpenseCategories() = repository.getExpenseCategories()
}