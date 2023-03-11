extends Node



func removeChildren(obj):
	for i in obj.get_children():
			i.queue_free()
