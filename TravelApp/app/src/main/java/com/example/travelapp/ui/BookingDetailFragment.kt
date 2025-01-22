package com.example.travelapp.ui

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import com.example.travelapp.R
import com.example.travelapp.model.Flight

class BookingDetailFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_booking_detail, container, false)
        val flight = arguments?.getParcelable<Flight>("selectedFlight")

        val flightNameTextView: TextView = view.findViewById(R.id.flightNameTextView)
        val flightStatusTextView: TextView = view.findViewById(R.id.flightStatusTextView)
        val flightDetailsTextView: TextView = view.findViewById(R.id.flightDetailsTextView)

        flightNameTextView.text = flight?.flightName
        flightStatusTextView.text = flight?.flightStatus
        flightDetailsTextView.text = flight?.flightDetails

        return view
    }
}