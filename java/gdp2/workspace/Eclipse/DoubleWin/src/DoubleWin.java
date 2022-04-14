import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.RadioButton;
import javafx.scene.control.TextField;
import javafx.scene.control.ToggleGroup;
import javafx.scene.image.Image;
import javafx.scene.layout.Pane;
import javafx.stage.Modality;
import javafx.stage.Stage;

public class DoubleWin extends Application {

    private PData p = new PData();

    private Stage createInputStage() {
        Stage inputStage = new Stage();
        Pane root = new Pane();

        Label nameLabel = new Label("Name:");
        nameLabel.setLayoutX(20);
        nameLabel.setLayoutY(20);
        root.getChildren().add(nameLabel);

        TextField nameText = new TextField(p.getName());
        nameText.setLayoutX(150);
        nameText.setLayoutY(18);
        nameText.setPrefWidth(240);
        root.getChildren().add(nameText);

        Label vornameLabel = new Label("Vorname:");
        vornameLabel.setLayoutX(20);
        vornameLabel.setLayoutY(50);
        root.getChildren().add(vornameLabel);

        TextField vornameText = new TextField(p.getVorname());
        vornameText.setLayoutX(150);
        vornameText.setLayoutY(48);
        vornameText.setPrefWidth(240);
        root.getChildren().add(vornameText);

        Label genderLabel = new Label("Geschlecht:");
        genderLabel.setLayoutX(20);
        genderLabel.setLayoutY(90);
        root.getChildren().add(genderLabel);

        RadioButton femaleRadio = new RadioButton();
        femaleRadio.setLayoutX(150);
        femaleRadio.setLayoutY(90);
        femaleRadio.setText("weiblich");
        root.getChildren().add(femaleRadio);

        RadioButton maleRadio = new RadioButton();
        maleRadio.setLayoutX(150);
        maleRadio.setLayoutY(120);
        maleRadio.setText("m�nnlich");
        root.getChildren().add(maleRadio);

        RadioButton divRadio = new RadioButton();
        divRadio.setLayoutX(150);
        divRadio.setLayoutY(150);
        divRadio.setText("divers");
        root.getChildren().add(divRadio);

        ToggleGroup genderGroup = new ToggleGroup();
        maleRadio.setToggleGroup(genderGroup);
        femaleRadio.setToggleGroup(genderGroup);
        divRadio.setToggleGroup(genderGroup);

        if (p.getGeschlecht().equals("weiblich"))
            femaleRadio.setSelected(true);
        else if (p.getGeschlecht().equals("m�nnlich"))
            maleRadio.setSelected(true);
        else
            divRadio.setSelected(true);

        Label natLabel = new Label("Staatsangeh�rigkeit:");
        natLabel.setLayoutX(20);
        natLabel.setLayoutY(190);
        root.getChildren().add(natLabel);

        ComboBox<String> natCombo = new ComboBox<String>();
        natCombo.setLayoutX(150);
        natCombo.setLayoutY(188);
        natCombo.setPrefWidth(240);
        natCombo.getItems().add("Chinesisch");
        natCombo.getItems().add("Deutsch");
        natCombo.getItems().add("Molwanisch");

        if (p.getStaat().isEmpty())
            natCombo.setValue("Bitte ausw�hlen");
        else
            natCombo.setValue(p.getStaat());

        root.getChildren().add(natCombo);

        Button okButton = new Button("Ok");
        okButton.setLayoutX(105);
        okButton.setLayoutY(240);
        okButton.setPrefWidth(100);
        okButton.setOnAction(e -> {
           // Abspeichern nach PData p
        	p.setName(nameText.getText());
            p.setVorname(vornameText.getText());

            if (femaleRadio.isSelected())
                p.setGeschlecht("weiblich");
            else if (maleRadio.isSelected())
                p.setGeschlecht("m�nnlich");
            else
                p.setGeschlecht("divers");

            p.setStaat(natCombo.getValue());
            inputStage.close();
        });
        okButton.setDefaultButton(true);
        root.getChildren().add(okButton);

        Button cancelButton = new Button("Abbrechen");
        cancelButton.setLayoutX(225);
        cancelButton.setLayoutY(240);
        cancelButton.setPrefWidth(100);
        cancelButton.setOnAction(e -> {
            inputStage.close();
        });
        cancelButton.setCancelButton(true);
        root.getChildren().add(cancelButton);

        Scene scene = new Scene(root, 425, 290);
        inputStage.setScene(scene);
        inputStage.setTitle("Pers�nliche Daten");
        inputStage.getIcons().add(new Image("thi_icon.png"));
        inputStage.initModality(Modality.APPLICATION_MODAL);
        return inputStage;
    }
    
    @Override
    public void start(Stage primaryStage) throws Exception {
        Pane root = new Pane();

        Button openButton = new Button("�ffne Pers�nliche Daten...");
        openButton.setLayoutX(35);
        openButton.setLayoutY(20);
        openButton.setOnAction(e-> {
            Stage inputStage = createInputStage();
            inputStage.show();
        });
        openButton.setDefaultButton(true);

        Scene scene = new Scene(root, 220, 70);
        primaryStage.setScene(scene);
        primaryStage.setTitle("InputWin");
        primaryStage.getIcons().add(new Image("thi_icon.png"));
        root.getChildren().add(openButton);
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }

}

