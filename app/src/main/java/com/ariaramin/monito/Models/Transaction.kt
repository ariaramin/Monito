package com.ariaramin.monito.Models

import android.os.Parcel
import android.os.Parcelable
import androidx.annotation.Nullable
import androidx.room.Embedded
import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.PrimaryKey

@Entity(tableName = "transaction_tbl")
data class Transaction(
    @Embedded
    var category: Category,
    @Nullable
    var note: String,
    var amount: String,
    var date: String
) : Parcelable {
    @PrimaryKey(autoGenerate = true)
    var transactionId: Long? = null

    constructor(parcel: Parcel) : this(
        parcel.readParcelable(Category::class.java.classLoader)!!,
        parcel.readString()!!,
        parcel.readString()!!,
        parcel.readString()!!
    ) {
        transactionId = parcel.readValue(Long::class.java.classLoader) as? Long
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeParcelable(category, flags)
        parcel.writeString(note)
        parcel.writeString(amount)
        parcel.writeString(date)
        parcel.writeValue(transactionId)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<Transaction> {
        override fun createFromParcel(parcel: Parcel): Transaction {
            return Transaction(parcel)
        }

        override fun newArray(size: Int): Array<Transaction?> {
            return arrayOfNulls(size)
        }
    }
}