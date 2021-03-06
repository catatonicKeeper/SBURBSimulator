import '../../SessionEngine/JSONObject.dart';
import '../../includes/path_utils.dart';
import "dart:async";
import 'dart:html';

class ContestEntry {

    String bbName;
    String entrantName;
    String imagesCSV;
    String jrComment;
    String text;
    String shogunComment;

    ContestEntry(String line) {
        JSONObject json = new JSONObject.fromJSONString(line);
        bbName = json["bbName"];
        entrantName = json["entrantName"];
        imagesCSV = json["imagesCSV"];
        jrComment = json["jrComment"];
        text = json["text"];
        shogunComment = json["shogunComment"];
    }

    static Future<List<ContestEntry>> slurpEntries() async{
        return await HttpRequest.getString(PathUtils.adjusted("BigBadLists/contestEntrants.txt")).then((String data) {
            List<ContestEntry> ret = new List<ContestEntry>();
            List<String> parts = data.split(new RegExp("\n|\r"));
            for(String line in parts) {
                //print("adding entry from $line");
                if(line.isNotEmpty) ret.add(new ContestEntry(line));
            }
            //print("returning entries $ret");
            return ret;
        });
    }

    static List<ContestEntry> filterBy(List<ContestEntry> entries, List<String> doop) {
        for(String s in doop) {
            print("s is $s");
            entries = new List.from(entries.where((ContestEntry e) {
                return e.bbName.contains(s) || e.entrantName.contains(s);
            }));
        }
        return entries ;
    }

    void draw(Element parentContainer, int number) {
        DivElement container = new DivElement();
        container.classes.add("contestEntry");

        AnchorElement nameElement = new AnchorElement(href: "BigBadBattle.html?target=${bbName.replaceAll(' ','_')}")..text = "$number $bbName";
        nameElement.style.color = "#00ff00";
        nameElement.classes.add("nameHeader");

        AnchorElement entrantElement = new AnchorElement(href: "BigBadBattle.html?target=${entrantName.replaceAll(' ','_')}")..text = "(by ${entrantName})";
        entrantElement.style.color = "#00ff00";
        entrantElement.classes.add("nameHeader");
        container.append(nameElement);
        container.append(entrantElement);

        DivElement bodyElement = new DivElement()..setInnerHtml(text);
        bodyElement.classes.add("bodyElement");
        container.append(bodyElement);

        DivElement jrNotes = new DivElement()..setInnerHtml("JR: $jrComment");
        jrNotes.classes.add("jrNotes");
        container.append(jrNotes);

        parentContainer.append(container);
    }

}