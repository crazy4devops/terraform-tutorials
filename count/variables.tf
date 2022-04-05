variable "filename" {
    type = list(string)
    default = [
        "./pet.txt",
        "./cat.txt",
        "./dog.txt"
       
    ]
  
}

variable "contentinthefile" {
    default = "we love pets!"
  
}