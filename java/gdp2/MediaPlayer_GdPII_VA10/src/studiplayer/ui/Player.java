package studiplayer.ui;

import java.net.URL;
import java.util.List;

import javafx.application.Application;
import javafx.application.Platform;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ContentDisplay;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.HBox;
import javafx.stage.Stage;
import studiplayer.audio.AudioFile;
import studiplayer.audio.NotPlayableException;
import studiplayer.audio.PlayList;

public class Player extends Application {
	
	private PlayList playList;
	public static final String DEFAULT_PLAYLIST = "playlists/DefaultPlayList.m3u";
	private String playListPathname;
	public static final String INITIAL_POS = "00:00";
	public static final String PREFIX = "Current song: ";
	private Label songDescription;
	private Label playTime;
	private Stage primaryStage;
	private volatile boolean stopped;
	private Button playButton;
	private Button pauseButton;
	private Button stopButton;
	private Button nextButton;
	private Button editorButton;
	private PlayListEditor playListEditor;
	private boolean editorVisible;
	
	private class TimerThread extends Thread {	
		public void run() {
			while ((!stopped && !playList.isEmpty())) {
				// runLater, damit es Funktioniert (Seite 13)
				Platform.runLater(() -> {
					playTime.setText(playList.getCurrentAudioFile().getFormattedPosition());
				});			
			
				
				try {
					sleep(100);
				}
				catch (InterruptedException e) {
				}
			}
		}
	}
	
	private class PlayerThread extends Thread {
		public void run() {
			while ((!stopped && !playList.isEmpty())) {
				try {
					// "Wartet" bis Wiedergabe beendet
					playList.getCurrentAudioFile().play();
				}
				catch(NotPlayableException e) {
					e.printStackTrace();
				}
			}
			
			if(!stopped) {
				playList.changeCurrent();
				updateSongInfo(playList.getCurrentAudioFile());
			}
		}
	}
	
	public Player() {
	}
	
	public void start(Stage pPrimaryStage) throws Exception {
		
		BorderPane mainPane = new BorderPane();
		primaryStage = pPrimaryStage;
		stopped = true;
		
		// Einlesen einer Playlist
		playList = new PlayList();
		List<String> parameters = getParameters().getRaw();
		if(parameters.size() == 1) {
			playListPathname = parameters.get(0);
			playList.loadFromM3U(playListPathname);
		}
		else {
			playListPathname = DEFAULT_PLAYLIST;
			playList.loadFromM3U(playListPathname);
		}
		
		playListEditor = new PlayListEditor(this, this.playList);
		editorVisible = false;
		
		// Label mit Namen des aktuellen Liedes
		songDescription = new Label("no current song");;
		mainPane.setTop(songDescription);
		songDescription.setPadding(new Insets(5));
		
		// Titel des Hauptfensters
		primaryStage.setTitle("no current song");
		
		// HBox für Steuerung und Abspielposition
		HBox control = new HBox();
		mainPane.setCenter(control);
		control.setAlignment(Pos.CENTER_LEFT);
		
		// Label mit Abspielposition
		playTime = new Label("--:--");
		control.getChildren().add(playTime);
		playTime.setPadding(new Insets(15));
		
		// Buttons für Steuerung
		playButton = createButton("play.png");
		control.getChildren().add(playButton);
		playButton.setOnAction(e -> {
			playCurrentSong();
		});
		pauseButton = createButton("pause.png");
		control.getChildren().add(pauseButton);
		pauseButton.setOnAction(e -> {
			pauseCurrentSong();
		});
		stopButton = createButton("stop.png");
		control.getChildren().add(stopButton);
		stopButton.setOnAction(e -> {
			stopCurrentSong();
		});
		nextButton = createButton("next.png");
		control.getChildren().add(nextButton);
		nextButton.setOnAction(e -> {
			nextSong();
		});
		editorButton = createButton("pl_editor.png");
		control.getChildren().add(editorButton);
		editorButton.setOnAction(e -> {
			if(editorVisible) {
				editorVisible = false;
				playListEditor.hide();
			}
			else {
				editorVisible = true;
				playListEditor.show();
			}
		});
		
		updateSongInfo(playList.getCurrentAudioFile());
		setButtonStates(true, false, true, false, true);
		
		Scene scene = new Scene(mainPane, 700, 90);
		primaryStage.setScene(scene);
		primaryStage.show();
				
		
		
		// TESTS: Beim Schließen des Fensters spielt der Song weiter, wenn nicht zuvor gestoppt
		// von Stackoverflow
		primaryStage.setOnCloseRequest(e -> {
			stopCurrentSong();
		});
	}
	
	public static void main(String[] args) {
		launch(args);
	}
	
	private Button createButton(String iconfile) {
		Button button = null;
		try {
			URL url = this.getClass().getResource("/icons/" + iconfile);
			Image icon = new Image(url.toString());
			ImageView imageView = new ImageView(icon);
			imageView.setFitHeight(48);
			imageView.setFitWidth(48);
			button = new Button("", imageView);
			button.setContentDisplay(ContentDisplay.GRAPHIC_ONLY);
		} catch (Exception e) {
			System.out.println("Image " + "icons/" + iconfile + " not found");
			System.exit(-1);
		}
		return button;
	}
	
	public void playCurrentSong() {
		
		if(!playList.isEmpty()) {
			AudioFile af = playList.getCurrentAudioFile();
			
			Platform.runLater(() -> {
				if(playList != null && playList.size() > 0) {
					updateSongInfo(af);
					setButtonStates(false, true, true, true, true);
				}
			});

			// Beenden des Songs bei Schließen des Players
			// Doppeltes Abspielen durch Doppelklick im Editor
			if(stopped == false) {
				stopCurrentSong();
			}
			
			stopped = false;
			
			if(af != null) {
				// Start Threads
				(new TimerThread()).start();
				(new PlayerThread()).start();
			}
		}
	}
	
	private void pauseCurrentSong() {
		setButtonStates(false, true, true, true, true);
		playList.getCurrentAudioFile().togglePause();
	}
	
	private void stopCurrentSong() {
		if(!playList.isEmpty()) {
			Platform.runLater(() -> {
				if(playList != null && playList.size() > 0) {
					updateSongInfo(playList.getCurrentAudioFile());
					setButtonStates(true, false, true, false, true);
				}
			});
			
			stopped = true;
			
			playList.getCurrentAudioFile().stop();
		}
	}
	
	private void nextSong() {
		if(!playList.isEmpty()) {
			if(!stopped) {
				stopCurrentSong();
			}
			playList.changeCurrent();
			playCurrentSong();
		}
	}
	
	private void updateSongInfo(AudioFile af) {
		if (af != null) {
			songDescription.setText(af.toString());
			primaryStage.setTitle(PREFIX + af.toString());
			playTime.setText(INITIAL_POS);
		}
		else {
			songDescription.setText("no current song");
			primaryStage.setTitle("no current song");
			playTime.setText("--:--");
		}
	}
	
	private void setButtonStates(boolean playButtonState, boolean stopButtonState,
			boolean nextButtonState, boolean pauseButtonState, boolean editorButtonState) {
		playButton.setDisable(!playButtonState);
		pauseButton.setDisable(!pauseButtonState);
		stopButton.setDisable(!stopButtonState);
		nextButton.setDisable(!nextButtonState);
		editorButton.setDisable(!editorButtonState);
	}
	
	public void setEditorVisible(boolean pEditorVisible) {
		editorVisible = pEditorVisible;
	}
	
	public String getPlayListPathname() {
		return playListPathname;
	}
	
	public void refreshUI() {
		Platform.runLater(() -> {
			if(playList != null && playList.size() > 0) {
				updateSongInfo(playList.getCurrentAudioFile());
				setButtonStates(true, false, true, false, true);
			} else {
				updateSongInfo(null);
				setButtonStates(true, true, true, true, true);
			}
		});
	}
	
	public void setPlayList(String playListPath) {
		boolean useDefault = false;
		
		if (!(playListPath == null)) {
			if (!playListPath.isEmpty()) {
				playListPathname = playListPath;
				playList.loadFromM3U(playListPathname);
			}
			else {
				useDefault = true;
			}
		}
		else {
			useDefault = true;
		}
		
		if(useDefault) {
			playListPathname = DEFAULT_PLAYLIST;
			playList.loadFromM3U(playListPathname);
		}
		
		refreshUI();
	}
}
