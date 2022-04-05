
resource "local_file" "petname" {
    filename = each.value
    content = var.contentinthefile
    for_each = toset(var.filename)
}