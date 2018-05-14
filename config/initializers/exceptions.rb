#　存在しないページにアクセスしようとした時のエラー：404
class CustomNotFound < Exception
end

# 読み出し禁止のページにアクセスした時のエラー：403
class CustomForbidden < Exception
end

# ユーザー不正操作の時のエラー：400
class CustomClientError < Exception
end
