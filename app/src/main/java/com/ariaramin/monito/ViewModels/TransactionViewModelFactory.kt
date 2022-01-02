package com.ariaramin.monito.ViewModels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.ariaramin.monito.Repositories.TransactionRepository

class TransactionViewModelFactory(private val repository: TransactionRepository) : ViewModelProvider.NewInstanceFactory() {
    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        return TransactionViewModel(repository) as T
    }
}