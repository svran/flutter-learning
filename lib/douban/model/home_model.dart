import 'dart:convert' show json;

class Project {

  int? errorCode;
  String? errorMsg;
  Data? data;

  Project.fromParams({this.errorCode, this.errorMsg, this.data});

  factory Project(Object jsonStr) => jsonStr is String ? Project.fromJson(json.decode(jsonStr)) : Project.fromJson(jsonStr);

  static Project? parse(jsonStr) => ['null', '', null].contains(jsonStr) ? null : Project(jsonStr);

  Project.fromJson(jsonRes) {
    errorCode = jsonRes['errorCode'];
    errorMsg = jsonRes['errorMsg'];
    data = jsonRes['data'] == null ? null : Data.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"errorCode": $errorCode, "errorMsg": ${errorMsg != null?'${json.encode(errorMsg)}':'null'}, "data": $data}';
  }

  String toJson() => this.toString();
}

class Data {

  int? curPage;
  int? offset;
  int? pageCount;
  int? size;
  int? total;
  bool? over;
  List<DataItem?>? datas;

  Data.fromParams({this.curPage, this.offset, this.pageCount, this.size, this.total, this.over, this.datas});

  Data.fromJson(jsonRes) {
    curPage = jsonRes['curPage'];
    offset = jsonRes['offset'];
    pageCount = jsonRes['pageCount'];
    size = jsonRes['size'];
    total = jsonRes['total'];
    over = jsonRes['over'];
    datas = jsonRes['datas'] == null ? null : [];

    for (var datasItem in datas == null ? [] : jsonRes['datas']){
      datas!.add(datasItem == null ? null : DataItem.fromJson(datasItem));
    }
  }

  @override
  String toString() {
    return '{"curPage": $curPage, "offset": $offset, "pageCount": $pageCount, "size": $size, "total": $total, "over": $over, "datas": $datas}';
  }

  String toJson() => this.toString();
}

class DataItem {

  int? audit;
  int? chapterId;
  int? courseId;
  int? id;
  int? publishTime;
  int? realSuperChapterId;
  int? selfVisible;
  int? shareDate;
  int? superChapterId;
  int? type;
  int? userId;
  int? visible;
  int? zan;
  bool? canEdit;
  bool? collect;
  bool? fresh;
  String? apkLink;
  String? author;
  String? chapterName;
  String? desc;
  String? descMd;
  String? envelopePic;
  String? host;
  String? link;
  String? niceDate;
  String? niceShareDate;
  String? origin;
  String? prefix;
  String? projectLink;
  String? shareUser;
  String? superChapterName;
  String? title;
  List<Tag?>? tags;

  DataItem.fromParams({this.audit, this.chapterId, this.courseId, this.id, this.publishTime, this.realSuperChapterId, this.selfVisible, this.shareDate, this.superChapterId, this.type, this.userId, this.visible, this.zan, this.canEdit, this.collect, this.fresh, this.apkLink, this.author, this.chapterName, this.desc, this.descMd, this.envelopePic, this.host, this.link, this.niceDate, this.niceShareDate, this.origin, this.prefix, this.projectLink, this.shareUser, this.superChapterName, this.title, this.tags});

  DataItem.fromJson(jsonRes) {
    audit = jsonRes['audit'];
    chapterId = jsonRes['chapterId'];
    courseId = jsonRes['courseId'];
    id = jsonRes['id'];
    publishTime = jsonRes['publishTime'];
    realSuperChapterId = jsonRes['realSuperChapterId'];
    selfVisible = jsonRes['selfVisible'];
    shareDate = jsonRes['shareDate'];
    superChapterId = jsonRes['superChapterId'];
    type = jsonRes['type'];
    userId = jsonRes['userId'];
    visible = jsonRes['visible'];
    zan = jsonRes['zan'];
    canEdit = jsonRes['canEdit'];
    collect = jsonRes['collect'];
    fresh = jsonRes['fresh'];
    apkLink = jsonRes['apkLink'];
    author = jsonRes['author'];
    chapterName = jsonRes['chapterName'];
    desc = jsonRes['desc'];
    descMd = jsonRes['descMd'];
    envelopePic = jsonRes['envelopePic'];
    host = jsonRes['host'];
    link = jsonRes['link'];
    niceDate = jsonRes['niceDate'];
    niceShareDate = jsonRes['niceShareDate'];
    origin = jsonRes['origin'];
    prefix = jsonRes['prefix'];
    projectLink = jsonRes['projectLink'];
    shareUser = jsonRes['shareUser'];
    superChapterName = jsonRes['superChapterName'];
    title = jsonRes['title'];
    tags = jsonRes['tags'] == null ? null : [];

    for (var tagsItem in tags == null ? [] : jsonRes['tags']){
      tags!.add(tagsItem == null ? null : Tag.fromJson(tagsItem));
    }
  }

  @override
  String toString() {
    return '{"audit": $audit, "chapterId": $chapterId, "courseId": $courseId, "id": $id, "publishTime": $publishTime, "realSuperChapterId": $realSuperChapterId, "selfVisible": $selfVisible, "shareDate": $shareDate, "superChapterId": $superChapterId, "type": $type, "userId": $userId, "visible": $visible, "zan": $zan, "canEdit": $canEdit, "collect": $collect, "fresh": $fresh, "apkLink": ${apkLink != null?'${json.encode(apkLink)}':'null'}, "author": ${author != null?'${json.encode(author)}':'null'}, "chapterName": ${chapterName != null?'${json.encode(chapterName)}':'null'}, "desc": ${desc != null?'${json.encode(desc)}':'null'}, "descMd": ${descMd != null?'${json.encode(descMd)}':'null'}, "envelopePic": ${envelopePic != null?'${json.encode(envelopePic)}':'null'}, "host": ${host != null?'${json.encode(host)}':'null'}, "link": ${link != null?'${json.encode(link)}':'null'}, "niceDate": ${niceDate != null?'${json.encode(niceDate)}':'null'}, "niceShareDate": ${niceShareDate != null?'${json.encode(niceShareDate)}':'null'}, "origin": ${origin != null?'${json.encode(origin)}':'null'}, "prefix": ${prefix != null?'${json.encode(prefix)}':'null'}, "projectLink": ${projectLink != null?'${json.encode(projectLink)}':'null'}, "shareUser": ${shareUser != null?'${json.encode(shareUser)}':'null'}, "superChapterName": ${superChapterName != null?'${json.encode(superChapterName)}':'null'}, "title": ${title != null?'${json.encode(title)}':'null'}, "tags": $tags}';
  }

  String toJson() => this.toString();
}

class Tag {

  String? name;
  String? url;

  Tag.fromParams({this.name, this.url});

  Tag.fromJson(jsonRes) {
    name = jsonRes['name'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"name": ${name != null?'${json.encode(name)}':'null'}, "url": ${url != null?'${json.encode(url)}':'null'}}';
  }

  String toJson() => this.toString();
}