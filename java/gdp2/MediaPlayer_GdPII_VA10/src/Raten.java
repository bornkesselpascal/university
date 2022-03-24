import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

public class Raten extends Application {
	private int lower = 0;
	private int upper = 1001;
	private int tipp;
	private int tippNumber = 1;
	
	public static void main(String[] args) {
		launch();
	}

	private int getTipp() {
		tippNumber++;
		if (lower == 999)
			tipp = 1000;
		else
			tipp = (lower + upper) / 2;
		return tipp;
	}

	private void rate(Label tippLabel) {
		if (lower >= upper - 1) {
			tippLabel.setText("Da ist was faul!");
			return;
		}
		tippLabel.setText("Mein " + tippNumber + ". Tipp: " + getTipp());
	}
	
	@Override
	public void start(Stage primaryStage) throws Exception {
		BorderPane mainPane = new BorderPane();
		primaryStage.setTitle("Zahlenraten");
		
		// Erläuterung im Top-Bereich
		Label explain1 = new Label("Sie denken sich eine Zahl zwischen 1 und 1000 aus.");
		Label explain2 = new Label("Ich werde sie erraten.");
		Label explain3 = new Label("Geben Sie mir nur Tipps, ob ich zu niedrig oder zu hoch geraten habe.");
		VBox explainBox = new VBox();
		explainBox.getChildren().addAll(explain1, explain2, explain3);
		mainPane.setTop(explainBox);
		
		// Tipp im Center-Bereich
		FlowPane centerPane = new FlowPane();
		Label tippLabel = new Label();
		
		// Hintergrundfarbe als CSS Style setzen
		centerPane.setStyle("-fx-background-color: lightblue");
		// Fettdruck
		tippLabel.setStyle("-fx-font-weight: bold");
		rate(tippLabel);
		centerPane.getChildren().add(tippLabel);
		FlowPane.setMargin(tippLabel, new Insets(10, 10, 10, 10));
		mainPane.setCenter(centerPane);
		
		// Benutzerfeedback im Bottom-Bereich
		FlowPane buttonPane = new FlowPane();
		Button zuGrossButton = new Button("zu gross");
		Button zuKleinButton = new Button("zu klein");
		Button dieIstEsButton = new Button("die ist es!");
		
		// Ereignisbehandlung mit Lambda-Expressions
		zuGrossButton.setOnAction(e -> {
			upper = tipp;
			rate(tippLabel);
		});
		zuKleinButton.setOnAction(e -> {
			lower = tipp;
			rate(tippLabel);
		});
		dieIstEsButton.setOnAction(e -> {
			tippLabel.setText("Na endlich!");
			zuGrossButton.setDisable(true);
			zuKleinButton.setDisable(true);
			dieIstEsButton.setDisable(true);
		});
		
		buttonPane.getChildren().addAll(zuGrossButton, zuKleinButton, dieIstEsButton);
		buttonPane.setHgap(10);
		buttonPane.setAlignment(Pos.CENTER);
		FlowPane.setMargin(zuGrossButton, new Insets(10, 10, 10, 10));
		FlowPane.setMargin(zuKleinButton, new Insets(10, 10, 10, 10));
		FlowPane.setMargin(dieIstEsButton, new Insets(10, 10, 10, 10));
		mainPane.setBottom(buttonPane);
		
		Scene scene = new Scene(mainPane, 400, 140);
		primaryStage.setScene(scene);
		primaryStage.show();		
	}
}
