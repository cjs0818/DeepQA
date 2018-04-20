import os
import gzip

"""
kist@kist:~$ cd PycharmProjects/seq2seq_test/
kist@kist:~/PycharmProjects/seq2seq_test$ python text_main.py 
********* 2 *********
[ caller 	] 아 여보세요
[ taker 	] 예 일일구에요
[ caller 	] 예 여기 애기가 저기 열이 너무 심해가지고
[ taker 	] 예 네네 그 주소가 어떻게 되세요
[ caller 	] 아산병원 여기 경 구리시 인창동이요
[ taker 	] 인창동
[ caller 	] 금 예 금호 어울림
[ taker 	] 금호 어울림 예
[ caller 	] 예 칠공 백이동 천이백오호
[ taker 	] 백이동 천이백 오호요
[ caller 	] 예예 그 동구는 백 그 건너편에 금호아파트에요
[ taker 	] 정거장 건너편이라구요 금호 어울림
[ caller 	] 예 금호아파트 예예
[ taker 	] 알겠습니다 고열이란 말이죠 예 구급대원이 가면서 전화 줄거에요
*********************

"""

class LISTENData:
    """

    """
    def __init__(self, dirName):
        """
        Args:
            dirName (string): directory where to load the corpus
        """


        self.caller = "[ caller 	] "
        self.taker = "[ taker 	] "
        self.CONVERSATION_SEP = "*********************"
        self.loadLines(dirName + '/listen.txt.gz')


    def loadLines(self, fileName):
        """
        Args:
            fileName (str): file to load
        Return:
            dict<dict<str>>: the extracted fields for each line
        """
        self.conversations = []

        #fileName = 'listen.txt.gz'

        cnt = 0

        linesBuffer = []
        with gzip.open(fileName, 'r') as f:  # TODO: Solve Iso encoding pb !
            for line in f:
                #print("-----10--------")

                line = line.decode('utf-8')
                line = line.strip()

                values_caller = line.split("[ caller 	] ")
                values_taker = line.split("[ taker 	] ")

                cnt += 1
                #print("line: ", line)
                print("cnt: ", cnt, "len(values_caller): ", len(values_caller), "len(values_taker): ", len(values_taker))


                if len(values_caller) > 1:
                    #print("values.caller[1]: ", values_caller[1])
                    linesBuffer.append({"text": values_caller[1]})

                if len(values_taker) > 1:
                    #print("values.taker[1]: ", values_taker[1])
                    linesBuffer.append({"text": values_taker[1]})



                if line == self.CONVERSATION_SEP:
                    self.conversations.append({"lines": linesBuffer})
                    #print(linesBuffer)
                    linesBuffer = []


    def getConversations(self):
        return self.conversations