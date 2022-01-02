package com.ariaramin.monito.ViewModels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.ariaramin.monito.Repositories.CategoryRepository

class CategoryViewModelFactory(private val repository: CategoryRepository) : ViewModelProvider.NewInstanceFactory() {
    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        return CategoryViewModel(repository) as T
    }
}