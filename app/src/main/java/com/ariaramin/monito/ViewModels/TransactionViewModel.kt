package com.ariaramin.monito.ViewModels

import androidx.lifecycle.ViewModel
import com.ariaramin.monito.Repositories.TransactionRepository
import com.ariaramin.monito.Models.Transaction
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class TransactionViewModel(private val repository: TransactionRepository) : ViewModel() {

    fun insertTransaction(transaction: Transaction) = GlobalScope.launch {
        repository.insertTransaction(transaction)
    }

    fun getAllTransactions() = repository.getAllTransaction()

    fun updateTransaction(transaction: Transaction) = GlobalScope.launch {
        repository.updateTransaction(transaction)
    }

    fun deleteTransaction(transaction: Transaction) = GlobalScope.launch {
        repository.deleteTransaction(transaction)
    }
}