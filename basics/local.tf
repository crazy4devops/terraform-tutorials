resource "local_file" "testfile" {
    content  = "Hi This is a sample text file"
    filename = "./test.txt"  
}