import java.util.List;

public abstract class User {

    protected String displayName;

    protected String id;

    protected String type;

    protected String href;

    protected List<User> follows;

    protected List<User> followers;

    protected ImgObj image;

    protected List<Album> albums;

    protected List<TrackObj> tracks;




}
