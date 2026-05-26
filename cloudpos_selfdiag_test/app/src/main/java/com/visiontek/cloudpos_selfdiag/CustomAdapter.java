package com.visiontek.cloudpos_selfdiag;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.List;

import androidx.recyclerview.widget.RecyclerView;

class CustomAdapter extends RecyclerView.Adapter<CustomAdapter.MyViewHolder> {

    private Context mContext;
    private List<DataModel> datalist;

    public class MyViewHolder extends RecyclerView.ViewHolder {
        public TextView title, values;
        public ImageView thumbnail;

        public MyViewHolder(View view) {
            super(view);
            title =  view.findViewById(R.id.title);
            values =  view.findViewById(R.id.values);
            thumbnail =  view.findViewById(R.id.thumbnail);

        }

    }

    public CustomAdapter(Context mContext, List<DataModel> datalist) {
        this.mContext = mContext;
        this.datalist = datalist;
    }

    @Override
    public MyViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.cards_layout, parent, false);

        return new MyViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(MyViewHolder holder, int position) {
        DataModel data = datalist.get(position);
        holder.title.setText(data.getName());
        holder.values.setText(data.getvalues());
        holder.thumbnail.setImageResource(data.getThumbnail());
    }


    @Override
    public int getItemCount() {
        return datalist.size();
    }
}

