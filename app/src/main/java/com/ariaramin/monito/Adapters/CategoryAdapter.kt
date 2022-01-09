package com.ariaramin.monito.Adapters

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.ariaramin.monito.Models.Category
import com.ariaramin.monito.Models.Transaction
import com.ariaramin.monito.R
import com.bumptech.glide.Glide

class CategoryAdapter(val itemEventListener: CategoryItemListener) :
    RecyclerView.Adapter<CategoryAdapter.CategoryViewHolder>() {

    private var categories: MutableList<Category> = ArrayList()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): CategoryViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.category_item, parent, false)
        return CategoryViewHolder(view)
    }

    override fun onBindViewHolder(holder: CategoryViewHolder, position: Int) {
        holder.bindData(categories[position])
    }

    override fun getItemCount(): Int {
        return categories.size
    }

    fun addItem(category: Category) {
        categories.add(0, category)
        notifyItemInserted(0)
    }

    fun addItemList(categoryList: List<Category>) {
        categories.addAll(categoryList)
        notifyDataSetChanged()
    }

    inner class CategoryViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        val titleTextView = itemView.findViewById<TextView>(R.id.categoryTitleTextView)
        val categoryImageView = itemView.findViewById<ImageView>(R.id.categoryImageView)

        fun bindData(category: Category) {
            titleTextView.text = category.title
            Glide.with(itemView)
                .load(category.image)
                .into(categoryImageView)
            itemView.setOnClickListener {
                itemEventListener.OnItemClick(category)
            }
        }
    }
}

interface CategoryItemListener {
    fun OnItemClick(category: Category)
}