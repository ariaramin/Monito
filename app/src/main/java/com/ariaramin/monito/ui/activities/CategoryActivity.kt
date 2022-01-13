package com.ariaramin.monito.ui.activities

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageView
import androidx.viewpager2.widget.ViewPager2
import com.ariaramin.monito.Adapters.ViewPagerAdapter
import com.ariaramin.monito.R
import com.google.android.material.tabs.TabLayout
import com.google.android.material.tabs.TabLayoutMediator

class CategoryActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_category)

        val backToHome = findViewById<ImageView>(R.id.backImageView3)
        backToHome.setOnClickListener {
            finish()
        }
        val tabLayout = findViewById<TabLayout>(R.id.tabLayout2)
        val viewPager = findViewById<ViewPager2>(R.id.viewPager2)
        val adapter = ViewPagerAdapter(supportFragmentManager, lifecycle)
        viewPager.adapter = adapter

        val tabs = arrayOf(
            resources.getString(R.string.expence),
            resources.getString(R.string.income)
        )
        TabLayoutMediator(tabLayout, viewPager) { tab, position ->
            tab.text = tabs[position]
        }.attach()
    }
}