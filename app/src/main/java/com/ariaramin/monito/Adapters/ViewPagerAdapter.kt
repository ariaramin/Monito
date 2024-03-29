package com.ariaramin.monito.Adapters

import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.Lifecycle
import androidx.viewpager2.adapter.FragmentStateAdapter
import com.ariaramin.monito.ui.fragments.bottomSheet.ExpenseCategoriesFragment
import com.ariaramin.monito.ui.fragments.bottomSheet.IncomeCategoriesFragment

class ViewPagerAdapter(fragmentManager: FragmentManager, lifecycle: Lifecycle) :
    FragmentStateAdapter(fragmentManager, lifecycle) {

    override fun getItemCount(): Int {
        return 2
    }

    override fun createFragment(position: Int): Fragment {
        when(position) {
            0 -> return ExpenseCategoriesFragment()
        }
        return IncomeCategoriesFragment()
    }
}