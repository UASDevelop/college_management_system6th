class Courses {
  String cname;
  int cid;
  Courses(this.cname, this.cid);
  @override
  String toString() {
    return '{ ${this.cname}, ${this.cid} }';
  }
}
