output "eksiamrolearn"{
  value = "${aws_iam_role.eksclusterrole.arn}"
}

output "eksnodegrouprolearn"{
  value = "${aws_iam_role.eksnodegrouprole.arn}"
}