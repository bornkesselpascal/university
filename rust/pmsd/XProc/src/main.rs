use std::{fs::File, io::Write};

fn main() {
    let mut file = File::create("test.xml").unwrap();
    file.write_all(b"<test></test>").unwrap();
    
    // Get the current time
    let now = std::time::SystemTime::now();

    // Write the current time to the file
    file.write_all(format!("\n<time>\n{}\n</time>\n", now.duration_since(std::time::UNIX_EPOCH).unwrap().as_secs()).as_bytes()).unwrap();

    // Log into nextcloud
    let client = reqwest::blocking::Client::new();
    let res = client.post("https://nextcloud.example.com/login").form(&[("user", "username"), ("password", "password")]).send().unwrap();

    // Download data from nextcloud and log into file
    let mut data = reqwest::blocking::get("https://nextcloud.example.com/remote.php/dav/files/username/").unwrap().text().unwrap();
    file.write_all(format!("\n<nextcloud>\n{}\n</nextcloud>\n", data).as_bytes()).unwrap();


}