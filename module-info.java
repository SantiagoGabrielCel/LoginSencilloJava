module Login {
    requires javafx.fxml;
    requires javafx.controls;
    requires java.desktop;
    requires java.sql;
    requires java.mail;
    requires org.apache.commons.codec.digest.DigestUtils;
    opens views;
    opens Controller;
}