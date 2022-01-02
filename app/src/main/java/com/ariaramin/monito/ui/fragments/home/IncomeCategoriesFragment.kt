package com.ariaramin.monito.ui.fragments.home

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.ariaramin.monito.Adapters.CategoryAdapter
import com.ariaramin.monito.Database.AppDatabase
import com.ariaramin.monito.R
import com.ariaramin.monito.Repositories.CategoryRepository
import com.ariaramin.monito.ViewModels.CategoryViewModel
import com.ariaramin.monito.ViewModels.CategoryViewModelFactory

class IncomeCategoriesFragment : Fragment() {

    private lateinit var viewModel: CategoryViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.income_categories_layout, container, false)

        val database = AppDatabase.getInstance(requireContext())
        val categoryRepository = CategoryRepository(database)
        val factory = CategoryViewModelFactory(categoryRepository)
        viewModel = ViewModelProvider(this, factory).get(CategoryViewModel::class.java)
        val recyclerView = view.findViewById<RecyclerView>(R.id.incomeCategoriesRecyclerView)
        val adapter = CategoryAdapter(requireContext())
        recyclerView.layoutManager = LinearLayoutManager(context)
        recyclerView.adapter = adapter

        viewModel.getIncomeCategories().observe(viewLifecycleOwner, {
            t -> adapter.addItemList(t)
        })

        return view
    }
}