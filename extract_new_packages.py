#!/usr/bin/env python
# coding: utf-8

# In[52]:


def read_data():
    f1 = open("packages-before.txt", "tr").readlines()
    f2 = open("packages-after.txt", "tr").readlines()
    
    for f in [f1, f2]:
        f.pop(0)  # get rid of "Listing...\n"

    f1 = [l.rstrip() for l in f1]
    f2 = [l.rstrip() for l in f2]
    
    print(f"f1 has {len(f1)} lines, f2 has {len(f2)-len(f1)} more")
    
    return f1, f2


# In[53]:


f1, f2 = read_data()


# In[54]:


diff1 = set(f1) - set(f2)
len(diff1)


# In[55]:


diff2 = set(f2) - set(f1)
len(diff2)


# In[66]:


assert sorted(list(diff1))[0:10] == []


# In[67]:


with open("new-packages.txt", "tw") as f_out:
    f_out.write("\n".join(sorted(list(diff2))))


# In[71]:


print("packages with 'x' in the name:")
for item in [x.split('/')[0] for x in sorted(set(f1).symmetric_difference(f2)) if 'x' in x]:
    print(f"- {item}")


# In[ ]:




