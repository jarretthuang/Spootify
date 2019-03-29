
-- Album1
DROP TABLE IF EXISTS tempAlbum1;
CREATE TEMPORARY TABLE tempAlbum1(
genre char(30), imageURL char(100), label char(40)
);

LOAD DATA LOCAL INFILE '/home/andy/cpsc304/Project/Album1Data.csv'
INTO TABLE tempAlbum1
FIELDS TERMINATED BY ','
(genre,imageURL,label); 

INSERT INTO Album1 (genre, imageURL, label)
SELECT genre, imageURL, label
FROM tempAlbum1;

DROP TABLE IF EXISTS tempAlbum1;

-- Album2
DROP TABLE IF EXISTS tempAlbum2;
CREATE TEMPORARY TABLE tempAlbum2(
albumID int(11), imageURL char(100)
);

LOAD DATA LOCAL INFILE '/home/andy/cpsc304/Project/Album2Data.csv'
INTO TABLE tempAlbum2
FIELDS TERMINATED BY ','
(albumID,imageURL); 

INSERT INTO Album2 (albumId, imageURL)
SELECT albumID, imageURL
FROM tempAlbum2;

DROP TABLE IF EXISTS tempAlbum2;

-- Track & Analytics
DROP TABLE IF EXISTS tempTracks;
CREATE TEMPORARY TABLE tempTracks(
 trackID int(11), acousticness float,danceability float, duration_ms float,
 energy float, instrumentalness float, analyticsKey int(11), liveness float,
 loudness float, unusedMode int(11), speechiness float, tempo float, 
 time_signature int(11), valence float, targ int(11), song_title char(30),
 artist char(30), genre char(30), imageURL char(100), label char(40), 
 albumID int(11), analyticsID int (11), artistID int(11), popularity int (11)
 );

LOAD DATA LOCAL INFILE '/home/andy/cpsc304/Project/trackData(no_names).csv'
INTO TABLE tempTracks
FIELDS TERMINATED BY ','
(trackID,acousticness,danceability,duration_ms,energy,instrumentalness,analyticsKey,   
 liveness,loudness,unusedMode,speechiness,tempo,time_signature,valence,targ,
 song_title,artist,genre,imageURL,label,albumID,analyticsID,artistID,popularity); 

SET FOREIGN_KEY_CHECKS=0;

INSERT INTO Track
(trackId, analyticsId, albumId, name, duration, popularity)
SELECT trackID, analyticsID, albumID, song_title, duration_ms, popularity
FROM tempTracks;

INSERT INTO Analytics
(trackId, analyticsId, liveliness, speechiness, danceability, instrumentalness,
 energy, analyticsKey, loudness, tempo)
 SELECT trackID, analyticsID, liveness, speechiness, danceability,
 instrumentalness, energy, analyticsKey, loudness, tempo
 FROM tempTracks;
 
 SET FOREIGN_KEY_CHECKS=1;

 INSERT INTO Artist1
 (imageURL, genre)
 SELECT imageURL, genre
 FROM tempTracks;


 -- Artist2
DROP TABLE IF EXISTS tempArtist2;
CREATE TEMPORARY TABLE tempArtist2(
artistId int(11), name char(100), imageURL char(100)
);

LOAD DATA LOCAL INFILE '/home/andy/cpsc304/Project/artist2.csv'
INTO TABLE tempArtist2
FIELDS TERMINATED BY ','
(artistId, name, imageURL); 

INSERT INTO Artist2 (artistId, name, imageURL)
SELECT artistId, name, imageURL
FROM tempArtist2;

DROP TABLE IF EXISTS tempArtist2;

-- User
DROP TABLE IF EXISTS tempUser;
CREATE TEMPORARY TABLE tempUser(
userId int(11), name char(30), imageURL char(100)
);
LOAD DATA LOCAL INFILE '/home/andy/cpsc304/Project/userData.csv'
INTO TABLE tempUser
FIELDS TERMINATED BY ','
(userId, name, imageURL);

INSERT INTO SpootifyUser
SELECT userId, name, imageURL
FROM tempUser;

DROP TABLE IF EXISTS tempUser;

-- Subscriber & BillingInfo
DROP TABLE IF EXISTS tempSubBilling;
CREATE TEMPORARY TABLE tempSubBilling(
userId int(11), subscriptionType char(30), cardNumber char(40), monthlyRate double
);
LOAD DATA LOCAL INFILE '/home/andy/cpsc304/Project/subData+billing.csv'
INTO TABLE tempSubBilling
FIELDS TERMINATED BY ','
(userId, subscriptionType, cardNumber, monthlyRate); 

SET FOREIGN_KEY_CHECKS=0;

INSERT INTO Subscriber
SELECT userId, subscriptionType, cardNumber
FROM tempSubBilling;

INSERT INTO BillingInfo (cardNumber, monthlyRate)
SELECT cardNumber, monthlyRate
FROM tempSubBilling;

SET FOREIGN_KEY_CHECKS=1;

DROP TABLE IF EXISTS tempSubBilling;

-- Guest
DROP TABLE IF EXISTS tempGuest;
CREATE TEMPORARY TABLE tempGuest(
userId int(11), balance double
);
LOAD DATA LOCAL INFILE '/home/andy/cpsc304/Project/guestData.csv'
INTO TABLE tempGuest
FIELDS TERMINATED BY ','
(userId, balance);

INSERT INTO Guest
SELECT userId, balance
FROM tempGuest;

DROP TABLE IF EXISTS tempGuest;

-- CreatesTrack
INSERT INTO CreatesTrack
SELECT artistID, trackID
FROM tempTracks;

-- Playlist
LOAD DATA LOCAL INFILE '/home/andy/cpsc304/Project/playlist.csv'
INTO TABLE Playlist
FIELDS TERMINATED BY ','
(playlistId, isPublic, description);

-- FollowsPlaylist
LOAD DATA LOCAL INFILE '/home/andy/cpsc304/Project/followsPlaylist.csv'
INTO TABLE FollowsPlaylist
FIELDS TERMINATED BY ','
(playlistId, userId);

-- TrackInPlaylist
LOAD DATA LOCAL INFILE '/home/andy/cpsc304/Project/trackInPlaylist.csv'
INTO TABLE TrackInPlaylist
FIELDS TERMINATED BY ','
(trackId, playlistId);

-- StoresAlbum
LOAD DATA LOCAL INFILE '/home/andy/cpsc304/Project/storesAlbum.csv'
INTO TABLE StoresAlbum
FIELDS TERMINATED BY ','
(userID, albumId);

-- StoresTrack
LOAD DATA LOCAL INFILE '/home/andy/cpsc304/Project/storesTrack.csv'
INTO TABLE StoresTrack
FIELDS TERMINATED BY ','
(userId, trackId);

DROP TABLE IF EXISTS tempTracks;







