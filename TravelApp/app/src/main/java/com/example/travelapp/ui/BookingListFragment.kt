package com.example.travelapp.ui

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.travelapp.R
import com.example.travelapp.adapter.BookingAdapter
import com.example.travelapp.api.FlightApiService
import com.example.travelapp.model.FlightResponse
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class BookingListFragment : Fragment() {

    private lateinit var recyclerView: RecyclerView
    private val flightApi = FlightApiService.create()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_booking_list, container, false)
        recyclerView = view.findViewById(R.id.recyclerView)
        recyclerView.layoutManager = LinearLayoutManager(requireContext())
        fetchFlights()
        return view
    }

    private fun fetchFlights() {
        flightApi.getFlights("9eae501080de69e4cf11540736062fa3").enqueue(object : Callback<FlightResponse>{
                override fun onResponse(call: Call<FlightResponse>, response: Response<FlightResponse>) {
                    Log.d("Response", response.toString())
                    if (response.isSuccessful) {
                        val flights = response.body()?.data ?: emptyList()
                        if (flights.isNotEmpty()) {
                            recyclerView.adapter = BookingAdapter(flights) { selectedFlight ->
                                val action = BookingListFragmentDirections
                                    .actionBookingListFragmentToBookingDetailFragment(selectedFlight)
                                findNavController().navigate(action)
                            }
                        } else {
                            Log.d("API Response", "No flights available.")
                            Toast.makeText(requireContext(), "No flights available.", Toast.LENGTH_SHORT).show()
                        }
                    } else {
                        Log.e("API Response", "Error: ${response.code()} - ${response.message()}")
                        Toast.makeText(requireContext(), "Error fetching flights: ${response.message()}", Toast.LENGTH_SHORT).show()
                    }
                }

                override fun onFailure(call: Call<FlightResponse>, t: Throwable) {
                    Log.e("API Failure", "Error: ${t.message}", t)
                    Toast.makeText(requireContext(), "Failed to fetch flights: ${t.message}", Toast.LENGTH_SHORT).show()
                }
            })

    }
}