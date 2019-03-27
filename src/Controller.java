import javax.sound.midi.Track;
import java.util.List;
import java.util.Map;

public class Controller {

    private Map<Integer, User> userDict;
    private Map<Integer, TrackObj> trackDict;
    private Map<Integer, Album> albumDict;
    private Map<Integer, PlayList> playlistDict;


    public User getUserFromDB(int userId) {

        boolean inDict = userDict.containsKey(userId);

        if (inDict) {
            return userDict.get(userId);
        }
        else {
            boolean subscriber = false;

            if (subscriber)
                return new Subscriber();
            else
                return new Guest();
        }
    }

    public TrackObj getTrackFromDB(int trackId) {

        return new TrackObj();
    }

    public Album getAlbumFromDB(int albumId) {

        return new Album();
    }

    public PlayList getPlaylistFromDB(int playlistId) {

        return new PlayList();
    }

    public Analytics getAnalyticsFromTrack(TrackObj track) {

        return new Analytics();
    }

    public BillingInfo getBillingInfo(Subscriber subscriber) {

        return new BillingInfo();
    }

    //==========================================================================

    // Return status code
    public int addTrackToUser(int userId, int trackId) {

        return 0;
    }

    // Return status code
    public int addTrackToPlaylist(int playlistId, int trackId) {

        return 0;
    }

    // Return new playlist ID
    public int createNewPlaylist(int userId, boolean isPublic, String name, String description) {

        return 0;
    }

    // Return status code
    public int modifyBillingInfo(int userId, int cardNum, double rate) {

        return 0;
    }

    // Return status code
    public int addAlbumToUser(int userId, int albumId) {

        return 0;
    }









}
















