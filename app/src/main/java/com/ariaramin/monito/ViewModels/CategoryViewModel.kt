package com.ariaramin.monito.ViewModels

import androidx.lifecycle.ViewModel
import com.ariaramin.monito.Models.Category
import com.ariaramin.monito.Repositories.CategoryRepository
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class CategoryViewModel(private val repository: CategoryRepository) : ViewModel() {

    fun insertCategory(category: Category) = GlobalScope.launch {
        repository.insertCategory(category)
    }

    fun getAllCategories() = repository.getAllCategories()

    fun getIncomeCategories() = repository.getIncomeCategories()

    fun getExpenseCategories() = repository.getExpenseCategories()
}