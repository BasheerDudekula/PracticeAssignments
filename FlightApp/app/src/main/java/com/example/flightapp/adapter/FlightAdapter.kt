package com.example.flightapp.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.flightapp.R
import com.example.flightapp.model.Flight

class FlightAdapter(private val onClick: (Flight) -> Unit) :
    RecyclerView.Adapter<FlightAdapter.FlightViewHolder>() {

    private val flights = mutableListOf<Flight>()

    @SuppressLint("NotifyDataSetChanged")
    fun submitList(newFlights: List<Flight>) {
        flights.clear()
        flights.addAll(newFlights)
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): FlightViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_flight, parent, false)
        return FlightViewHolder(view)
    }

    override fun onBindViewHolder(holder: FlightViewHolder, position: Int) {
        val flight = flights[position]
        holder.bind(flight)
    }

    override fun getItemCount() = flights.size

    inner class FlightViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        private val name: TextView = itemView.findViewById(R.id.airlineName)

        fun bind(flight: Flight) {
            name.text = flight.airline_name
            itemView.setOnClickListener { onClick(flight) }
        }
    }
}