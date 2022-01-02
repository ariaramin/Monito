package com.ariaramin.monito.ViewModels

import androidx.lifecycle.ViewModel
import com.ariaramin.monito.Repositories.TransactionRepository
import com.ariaramin.monito.Models.Transaction

class TransactionViewModel(private val repository: TransactionRepository) : ViewModel() {

    fun insertTransaction(transaction: Transaction) = repository.insertTransaction(transaction)

    fun getAllTransactions() = repository.getAllTransaction()

    fun updateTransaction(transaction: Transaction) = repository.updateTransaction(transaction)

    fun deleteTransaction(transaction: Transaction) = repository.deleteTransaction(transaction)
}