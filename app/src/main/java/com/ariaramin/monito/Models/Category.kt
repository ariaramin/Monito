package com.ariaramin.monito.Models

import android.graphics.Bitmap
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "category_tbl")
data class Category(
    var title: String,
    var type: String,
    var image: Bitmap
) {
    @PrimaryKey(autoGenerate = true)
    var id: Long? = null
}