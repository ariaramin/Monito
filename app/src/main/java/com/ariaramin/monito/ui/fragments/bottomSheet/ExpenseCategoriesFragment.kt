package com.ariaramin.monito.ui.fragments.bottomSheet

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.ariaramin.monito.Adapters.CategoryAdapter
import com.ariaramin.monito.Database.AppDatabase
import com.ariaramin.monito.R
import com.ariaramin.monito.Repositories.CategoryRepository
import com.ariaramin.monito.ViewModels.CategoryViewModel
import com.ariaramin.monito.ViewModels.CategoryViewModelFactory
import com.ariaramin.monito.ui.activities.TransactionActivity

class ExpenseCategoriesFragment : Fragment() {

    private lateinit var viewModel: CategoryViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.categories_layout, container, false)

        val database = AppDatabase.getInstance(requireContext())
        val categoryRepository = CategoryRepository(database)
        val factory = CategoryViewModelFactory(categoryRepository)
        viewModel = ViewModelProvider(this, factory).get(CategoryViewModel::class.java)
        val recyclerView = view.findViewById<RecyclerView>(R.id.categoriesRecyclerView)
        val adapter = CategoryAdapter(TransactionActivity())
        val layoutManager = LinearLayoutManager(context)
        val dividerItemDecoration = DividerItemDecoration(context, layoutManager.orientation)
        recyclerView.layoutManager = layoutManager
        recyclerView.adapter = adapter
        recyclerView.addItemDecoration(dividerItemDecoration)
        if (adapter.itemCount <= 0) {
            viewModel.getExpenseCategories().observe(viewLifecycleOwner, { t ->
                adapter.addItemList(t)
            })
        }
        return view
    }
}