package com.visiontek.cloudpos_selfdiag;

class DataModel {
    private String name;
    private String values;
    private int thumbnail;

    public DataModel() {
    }

    public DataModel(String name, String values, int thumbnail) {
        this.name = name;
        this.values = values;
        this.thumbnail = thumbnail;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getvalues() {
        return values;
    }

    public void setvalues(String values) {
        this.values = values;
    }

    public int getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(int thumbnail) {
        this.thumbnail = thumbnail;
    }


}