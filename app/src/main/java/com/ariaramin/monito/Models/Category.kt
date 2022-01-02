package com.ariaramin.monito.Models

import android.graphics.Bitmap
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "category_tbl")
data class Category(
    @PrimaryKey(autoGenerate = true)
    val id: Long,
    val title: String,
    val type: String,
    val image: Bitmap
)