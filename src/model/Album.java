package model;

import java.util.List;

public class Album {

    private String album_type;

    private List<Artist> artists;

    private String href;

    private List<String> genres;

    String id;

    List<ImgObj> images;

    String label;

    String name;

    int populatiry;

    String release_date; // The date the album was first released, for example 1981

    String type; // The object type: “album”

    String uri;

    List<TrackObj> tracks;


}
