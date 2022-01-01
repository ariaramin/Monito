package com.ariaramin.monito.ui.fragments.home

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.ariaramin.monito.Adapter.TransactionAdapter
import com.ariaramin.monito.Database.AppDatabase
import com.ariaramin.monito.R
import com.ariaramin.monito.Repo.TransactionRepository
import com.ariaramin.monito.models.Transaction
import com.ariaramin.monito.ui.activities.TransactionViewModel
import com.ariaramin.monito.ui.activities.TransactionViewModelFactory

class HomeFragment : Fragment() {

    companion object {
        fun newInstance() = HomeFragment()
    }

    private lateinit var viewModel: TransactionViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.home_fragment, container, false)

        val database = AppDatabase.getInstance(requireContext())
        val transactionRepository = TransactionRepository(database)
        val factory = TransactionViewModelFactory(transactionRepository)

        // Initialised View Model
        viewModel = ViewModelProvider(this, factory).get(TransactionViewModel::class.java)
        val transactionAdapter = TransactionAdapter(requireContext())
        val recyclerView = view.findViewById<RecyclerView>(R.id.transactionRecyclerView)
        recyclerView.layoutManager = LinearLayoutManager(this.context)
        recyclerView.adapter = transactionAdapter

        // To display all items in recycler view
        viewModel.getAllTransactions().observe(viewLifecycleOwner,
            { t -> transactionAdapter.addItemList(t!!) }
        )
        return view
    }
}