local function Shaar(msg)
local text = msg.content_.text_
if text then
if text == 'تفعيل تنبيه الاشعار' and Owner(msg) then
send(msg.chat_id_, msg.id_,'🔖┇ تم تفعيل التنبيه عل شعار  !')
redis:set(bot_id..'TeKToK:SH:BOT'..msg.chat_id_,true)
return false
end
if text == 'تعطيل تنبيه الاشعار' and Owner(msg) then
send(msg.chat_id_, msg.id_,'📮┇ تم تعطيل التنبيه عل شعار  !')
redis:del(bot_id..'TeKToK:SH:BOT'..msg.chat_id_)
return false
end
if text and text:match('^وضع الشعار (.*)$') and Owner(msg) then
local SHGP = text:match('^وضع الشعار (.*)$')
redis:set(bot_id..'TeKToK:SH:BOT:GP'..msg.chat_id_,SHGP)
send(msg.chat_id_, msg.id_,'📮┇تم حفظ شعار المجموعه \n')
end
end
if text and redis:get(bot_id..'TeKToK:SH:BOT'..msg.chat_id_) and not Owner(msg) then
if tonumber(redis:get(bot_id..'TeKToK:SH:NUM'..msg.chat_id_..msg.sender_user_id_) or 0) > 3 then
KickGroup(msg.chat_id_,msg.sender_user_id_) 
send(msg.chat_id_, msg.id_,'📮┇ تم طردك من المجموعة لعدم احترام قوانين المجموعة')
redis:del(bot_id..'TeKToK:SH:NUM'..msg.chat_id_..msg.sender_user_id_)
else
tdcli_function ({ID = 'GetUser',user_id_ = msg.sender_user_id_},function(arg,data) 
local last_ = data.last_name_ or ''
local first_ = data.first_name_ or ''
local taha = (first_..''..last_)
local taha1 = (redis:get(bot_id..'TeKToK:SH:BOT:GP'..msg.chat_id_) or '')
if string.find(taha,taha1) == nil then
local taha = tonumber((redis:get(bot_id..'TeKToK:SH:NUM'..msg.chat_id_..msg.sender_user_id_) or 0))
if taha == 1 then
send(msg.chat_id_, msg.id_,'\n♨┇ عليك وضع شعار المجموعه لديك {3} محاولات وعند انتهاء المحاولات سيتم طردك الشعار {`'..taha1..'`}')
elseif taha == 2 then
send(msg.chat_id_, msg.id_,'\n♨┇ عليك وضع شعار المجموعه لديك {2} محاولات وعند انتهاء المحاولات سيتم طردك الشعار {`'..taha1..'`}')
elseif taha == 3 then
send(msg.chat_id_, msg.id_,'\n♨┇ عليك وضع شعار المجموعه لديك اخر محاولات لوضع الشعار {`'..taha1..'`}')
end
redis:incrby(bot_id..'TeKToK:SH:NUM'..msg.chat_id_..msg.sender_user_id_,1)
end
end,nil)  
return false
end
end

end
return {
tektokFile = Shaar
}