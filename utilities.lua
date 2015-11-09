-- ���������װ
--��������x,y �������λ�ã�x��y�������ƫ������5������
function click(x, y)--���С���ȵ��
    touchDown(0, x + math.random(-5, 5), y + math.random(-5, 5))
    mSleep(math.random(15,50))
    touchUp(0)
    mSleep(math.random(200,500))
end

--ͼƬ·��
--��������ű�·��Ϊ'/var/touchelf/scripts/'
--ÿ����ͬ��Ӧ����Ӧ�����������ļ��д��ͼƬ
--����Ѫ����Ϊ�����ýű���ͼƬ·��ȫ�ֲ�������
PIC_PATH = '/var/touchelf/scripts/rexuechuanqi/'

--��ӡ��־����
--����messageΪ�������log.txt�����ݣ�������ȫ�ֲ���isLogΪtrue
--����isLog��Ϊ�˵���ʱ���ӡ��־��λ���⣬�ű�����֮��ɽ�ȫ�ֲ���isLog����Ϊfalse�򲻻��ӡ��־
function printLog(message)
tt = os.date("*t")
yy = tt.year
mm = tt.month
dd = tt.day
local curdate = yy..mm..dd
	if isLog == true then
		logDebug(curdate..message)
	end
end

--��ʾ����
--�����÷�����մ�ӡ��־����printLog
function myNotify(message)
	if isNotify == true then
		notifyMessage(message)
		mSleep(2500)
	end
end

--���»�������
--����x1,y1��һ���㣬x2��y2λ�ڶ����㣬speedΪ�����ٶ�
--�ú���ּ�ڽ�����������,�ﵽ��������ȷ��Ŀ��
function myMove_UD(x1, y1, x2, y2,speed)
    local step = speed
    if y2 > y1 then step = -speed end 
    local cnt = math.abs((y2 - y1) /speed)
    if cnt == 0 then
        cnt = 1
        step = math.abs(y2 - y1)
    end
    touchDown(0, x1, y1)
    mSleep(50)
    for i = 1, cnt do
        mSleep(50)
        y1 = y1 - step
        touchMove(0, x1, y1)
    end
    touchUp(0)
    mSleep(100)
end

--���һ�������
--ͬmyMove_UD
function myMove_RL(x1, y1, x2, y2,speed)
    local step = speed
    if x2 > x1 then step = -speed end 
    local cnt = math.abs((x2 - x1) / speed)
    if cnt == 0 then
        cnt = 1
        step = math.abs(x2 - x1)
    end
    touchDown(0, x1, y1)
	mSleep(50)
    for i = 1, cnt do
        mSleep(50)
        x1 = x1 - step
        touchMove(0, x1, y1)
    end
    touchUp(0)
    mSleep(100)
end

--����ģ����ͼ
--picΪͼƬ����,perΪ����(����85����),x1,y1,x2,y2Ϊ���ҷ�Χ�����Ͻ����������½�����
--PIC_PATHΪȫ��ͼƬ�ļ���·��
function FindByPic(pic,per,x1,y1,x2,y2)
	x, y = findImageInRegionFuzzy(PIC_PATH..pic, per, x1,y1,x2,y2)
	if x~=-1 and y~=-1 then		
		return true		
	else
		return false
	end	
end	
-- ����ɫ��ͼ
--colorΪ������ɫ��ֵ,������������������ģ����ͼ
--һ��ͼƬ��ʱ�򱳾�ɫһֱ�仯������������ɫ���䣬����Ҫ��ͼ����ʹ�ú���ɫ��ͼ������color���������Լ�ʵ�ʴ���Ľ����д
--�ƽ鳣�ù���Ϊphotoshop����Į�ۺϹ���
function FindPicByColor(pic,per,x1,y1,x2,y2,color)
	keepScreen(true)
	x, y = findImageInRegionFuzzy(PIC_PATH..pic,per,x1,y1,x2,y2,color)
	if x~=-1 and y~=-1 then
		keepScreen(false)
		return true		
	else
		keepScreen(false)
		return false
	end	
end	

--ʹ�ô�Į�ۺϹ��߲�����ʹ�����º�����ͼƬʹ��win7�Դ��Ļ�ͼ���ߴ�֮��
--ʵ���������ֻ�����ϵͳ��5�����ظ�ƫ��ڴ�������api��������Ҫ���������ֵ��ȥ5�����ظ�
function DmFindPic(pic,per,x1,y1,x2,y2)
	keepScreen(true)
	x, y = findImageInRegionFuzzy(PIC_PATH..pic, per, x1-5,y1-5,x2-5,y2-5)
	if x~=-1 and y~=-1 then	
		keepScreen(false)	
		return true		
	else
		keepScreen(false)
		return false
	end	
end	

-- ͬ��
function DmFindPicFuzzy(pic,per,x1,y1,x2,y2,color)
	keepScreen(true)
	x, y = findImageInRegionFuzzy(PIC_PATH..pic,per,x1-5,y1-5,x2-5,y2-5,color)
	if x~=-1 and y~=-1 then
		keepScreen(false)
		return true		
	else
		keepScreen(false)
		return false
	end	
end	
--������ɫ�������÷�������
--�������Ļ����Ϊtest��ͼ�������
if DmFindPic('test.bmp',90,1,2,3,4) then
	click(x,y)
end


--�ı�����ɾ��ָ����
--����ɾ��������
--����ԭ�����ı��������ж��뵽table���ٸ���index�������table.remove����ɾ��table��index��
--�ٽ�table�е�ֵ����д�뵽ԭ�ı�
function removeByIndex(index)
	local t={}
    local file=io.open("var/touchelf/scripts/test.txt")
    for line in file:lines() do
		table.insert(t,line)
    end
    temp_line=table.remove(t,index)
    local file=io.open("var/touchelf/scripts/test.txt",'w')
    for i,j in ipairs(t) do
		file:write(j,'\n')
    end
    file:close()
    return temp_line
end  

--����ַ���
--����nΪ��Ҫ�õ��ַ����ĳ���
function randomstring(n)
		local chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
		local strs = ''
		math.randomseed(tostring(os.time()):reverse():sub(1,n))
		for i = 1,n do
			local index = math.random(string.len(chars))
			strs = strs..string.sub(chars,index,index)
		end
		return strs
end

--�ָ��ַ���
--local list = Split("abc,123,345", ",")--ʾ��
function Split(szFullString, szSeparator)  
	local nFindStartIndex = 1  
	local nSplitIndex = 1  
	local nSplitArray = {}  
	while true do  
	   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)  
	   if not nFindLastIndex then  
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))  
		break  
	   end  
	   nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)  
	   nFindStartIndex = nFindLastIndex + string.len(szSeparator)  
	   nSplitIndex = nSplitIndex + 1  
	end  
	return nSplitArray  
end  

--�л�ip������idΪȫ�ֲ�������������UI���������������ʽ����
--����id�������ж��壬router�����ڲ���Ҫ�����޸ģ����������ַ�����������µ�ַΪ׼
function router()
	local index = id
	index = string.match(index,"%s*(.-)%s*$")	
	url = 'id%3d'..index..'%26type%3ddown%26shell_data%3dinternet%253DMAC_VLAN%2binterface%253Dwan1%26r%3d0.43528579045092863'	
	local tt = os.time()
	local ipAddress = 0
	while true do
		ipAddress = httpGet('http://ip.3322.net/')
		local ret = string.match(ipAddress,'%d+')
		if ret ~= nil then
			notifyMessage('ip:'..ipAddress)
			break
		elseif ret == nil then
			notifyMessage('����ʧ��,��ȴ�')
			mSleep(5000)
		elseif os.difftime(os.time(),tt) > 90 then
			os.execute('reboot')
		end	
	end
	
	routerControl(getDeviceID(),url)
	mSleep(10000)
	local count = 0
	while true do
		local curIp = httpGet('http://ip.3322.net/')
		notifyMessage(curIp)
		if curRet ~= '' and curIp ~= ipAddress then
			notifyMessage('�����ɹ�')
			break
		elseif count > 5 then
			for i = 1,10 do
				notifyMessage('����5�λ�û�ϳɹ�,���˹���Ԥһ��,����5�λ�û�ϳɹ�,���˹���Ԥһ��,����5�λ�û�ϳɹ�,���˹���Ԥһ��,����5�λ�û�ϳɹ�,���˹���Ԥһ��,����5�λ�û�ϳɹ�,���˹���Ԥһ��,����5�λ�û�ϳɹ�,���˹���Ԥһ��,����5�λ�û�ϳɹ�,���˹���Ԥһ��,����5�λ�û�ϳɹ�,���˹���Ԥһ��!����5�λ�û�ϳɹ�,���˹���Ԥһ��!����5�λ�û�ϳɹ�,���˹���Ԥһ��!����5�λ�û�ϳɹ�,���˹���Ԥһ��!����5�λ�û�ϳɹ�,���˹���Ԥһ��!����5�λ�û�ϳɹ�,���˹���Ԥһ��!����5�λ�û�ϳɹ�,���˹���Ԥһ��!����5�λ�û�ϳɹ�,���˹���Ԥһ��!����5�λ�û�ϳɹ�,���˹���Ԥһ��!')
				mSleep(2000)
			end
		else
			notifyMessage('����ʧ��,��������')
			routerControl(getDeviceID(),url)
			count = count + 1
		end
	end
end


function routerControl(deviceId,url)
	local data = httpGet('http://192.168.1.8:7356/makemoney/android/ad/router?action=control&sn='..getDeviceID()..'&url='..url)
	local i,j = string.find(data,'ok')
	if i~=nil and j~=nil then
		notifyMessage('��������ɹ�')
		mSleep(5000)
	else
		notifyMessage('��������ʧ��')
		mSleep(5000)
	end	
end