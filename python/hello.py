'''print("hello world")
print("hi")
print("hey")
print("bye")
import re
file_open=open("input.txt", 'rt')
content=file_open.read()
#print(len(content))
n = input()
t = re.findall(n, content, re.M|re.I)
i = 0
r = []
m=0
#print(len(t))
while i < len(t):
    if i == 0:
        f=re.search(t[i],content)
        i+=1
        k=f.span()
        m=k[1]
        r.append(content[k[0]-10:k[0]]+' '+n+' '+content[k[1]+1:k[1]+10])
    else:
        f=re.search(t[i],content[m+1:])
        i+=1
        k=f.span()
        m=k[1]
        r.append(content[k[0]-10:k[0]]+' '+n+' '+content[k[1]+1:k[1]+10])
ma=[]
ma.append(str(len(t)))
for y in range(1, len(r)+1):
    ma.append(str(y)+": "+r[y-1].strip())

#print(len(r))
#print(len(k))
#for s in range(len(r)):
    #print(str(s+1)+": ",r[s])
x = n+".txt"
with open(x,'a') as a:
    #a.writelines(str(len(t))
    a.writelines('\n'.join(ma))


    #k=re.search(n,content,re.M|re.I)
    #t=k.span()
    #print(t[1])
    #print(content[125:140])
    #print(k)i = 1
'''#for n in t:
    #print(str(i)+':',n)
    #i+=1
#print(len(t))
'''with open("out.txt", "a") as f:
   ''' #f.writelines('\n'.join(t))'''
    #f.write(t)'''
import re
# searching class
class search_word:
    def search_function(self, search_word):
        # searching function for given word
        self.search_word = search_word
        file_open = open("input.txt", 'rt')
        content = file_open.read()
        word_found = re.findall(search_word, content, re.M | re.I)
        one_num = 0
        store_word = []
        store_span = 0
        while one_num < len(word_found):
            if one_num == 0:
                word_got = re.search(word_found[one_num], content)
                one_num + = 1
                get_span = word_got.span()
                store_span = get_span[1]
                store_word.append(content[get_span[0]-10:get_span[0]]+' '+n+' '+content[get_span[1]+1:get_span[1]+10])
            else:
                word_got = re.search(word_found[one_num], content[store_span + 1:])
                one_num + = 1
                get_span = word_got.span()
                store_span = get_span[1]
                store_word.append(content[get_span[0]-10:get_span[0]]+' '+n+' '+content[get_span[1]+1:get_span[1]+10])
        conv_str = []
        conv_str.append(str(len(word_found)))
        for y in range(1, len(store_word)+1):
            conv_str.append(str(y) + ": " + store_word[y-1].strip())
        out_txt = search_word + ".txt"
        with open(out_txt, 'a') as file_out:
            file_out.writelines('\n'.join(conv_str))
if __name__ == "__main__":
    object_search = search_word()
    search_word = input("enter search word: ")
    object_search.search_function(search_word)

