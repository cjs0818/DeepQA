import os
import gzip

"""
Load the cornell movie dialog corpus.

Available from here:
http://www.cs.cornell.edu/~cristian/Cornell_Movie-Dialogs_Corpus.html

"""

class FBData:
    """

    """
    def __init__(self, dirName):
        """
        Args:
            dirName (string): directory where to load the corpus
        """

        self.conversations = self.loadConversations(
            os.path.join(dirName, "all.txt.gz"))

        # TODO: Cleaner program (merge copy-paste) !!

    def loadConversations(self, fileName):
        """
        Args:
            fileName (str): file to load
        Return:
            dict<dict<str>>: the extracted fields for each line
        """
        conversations = []

        with gzip.open(fileName, 'r') as f:  # TODO: Solve Iso encoding pb !
            for line in f:
                line = line.decode('utf-8')
                values = line.split("\t")

                for i in range(3, len(values), 2):
                    q = {'like_count': values[0], 'text': values[1]}
                    a = {'like_count': values[i-1], 'text': values[i]}

                    convObj = {}
                    convObj["lines"] = []
                    convObj["lines"].append(q)
                    convObj["lines"].append(a)
                    conversations.append(convObj)
        return conversations

    def getConversations(self):
        return self.conversations


if __name__ == "__main__":
    import pprint
    corpusDir = os.path.join('..', 'data', 'fbdata')

    fbData = FBData(corpusDir)
    conversations = fbData.getConversations()
    for conversation in conversations:
        for i in range(len(conversation[
                               "lines"]) - 1):  # We ignore the last line (no answer for it)
            inputLine = conversation["lines"][i]
            targetLine = conversation["lines"][i + 1]
            print("input: ", inputLine['text'], "target: ",
                  targetLine['text'])
