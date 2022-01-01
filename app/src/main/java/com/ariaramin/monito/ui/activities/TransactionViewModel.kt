package com.ariaramin.monito.ui.activities

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.ariaramin.monito.Repo.TransactionRepository
import com.ariaramin.monito.models.Transaction

class TransactionViewModel(private val repository: TransactionRepository) : ViewModel() {

    private var transactionLiveData: MutableLiveData<List<Transaction>>? = null

    fun insertTransaction(transaction: Transaction) = repository.insertTransaction(transaction)

    fun getAllTransactions() = repository.getAllTransaction()

    fun updateTransaction(transaction: Transaction) = repository.updateTransaction(transaction)

    fun deleteTransaction(transaction: Transaction) = repository.deleteTransaction(transaction)
}