package com.ariaramin.monito.dialog

import android.app.Dialog
import android.os.Bundle
import androidx.fragment.app.DialogFragment
import android.app.AlertDialog
import android.view.LayoutInflater
import android.widget.Button
import com.ariaramin.monito.R
import com.ariaramin.monito.models.Transaction
import com.google.android.material.chip.Chip
import com.google.android.material.textfield.TextInputEditText
import com.google.android.material.textfield.TextInputLayout

class TransactionDialog() : DialogFragment() {

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        val builder = AlertDialog.Builder(activity)
        val view = LayoutInflater.from(activity).inflate(R.layout.transaction_dialog, null, false)
        val noteEditTextLayout = view.findViewById<TextInputLayout>(R.id.noteDialogEditTextLayout)
        val noteEditText = view.findViewById<TextInputEditText>(R.id.noteDialogEditText)
        val dateChip = view.findViewById<Chip>(R.id.dateChip)
        val categoryChip = view.findViewById<Chip>(R.id.categoryChip)
        val saveTransactionButton = view.findViewById<Button>(R.id.saveTransactionButton)
        saveTransactionButton.setOnClickListener {
            if (noteEditText.length() > 0) {

            }
        }
        builder.setView(view)
        return builder.create()
    }

}