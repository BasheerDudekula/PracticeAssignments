package com.example.travelapp.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.travelapp.R
import com.example.travelapp.model.Flight

class BookingAdapter(
    private val flights: List<Flight>,
    private val onClick: (Flight) -> Unit
) : RecyclerView.Adapter<BookingAdapter.BookingViewHolder>() {

    inner class BookingViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        private val flightName: TextView = itemView.findViewById(R.id.flightNameTextView)

        fun bind(flight: Flight) {
            flightName.text = flight.flightName
            itemView.setOnClickListener { onClick(flight) }
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): BookingViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_flight, parent, false)
        return BookingViewHolder(view)
    }

    override fun onBindViewHolder(holder: BookingViewHolder, position: Int) {
        holder.bind(flights[position])
    }

    override fun getItemCount(): Int = flights.size
}