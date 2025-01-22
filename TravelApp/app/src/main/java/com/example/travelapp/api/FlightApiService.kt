package com.example.travelapp.api

import com.example.travelapp.model.FlightResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface FlightApiService {

    @GET("v1/flights")
    fun getFlights(@Query("access_key") apiKey: String): Call<FlightResponse>

    companion object {
        private const val BASE_URL = "https://api.aviationstack.com/"

        fun create(): FlightApiService {
            val retrofit = retrofit2.Retrofit.Builder()
                .baseUrl(BASE_URL)
                .addConverterFactory(retrofit2.converter.gson.GsonConverterFactory.create())
                .build()
            return retrofit.create(FlightApiService::class.java)
        }
    }
}
