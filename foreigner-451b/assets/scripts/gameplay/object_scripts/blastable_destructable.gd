extends Blastable

func accept_blast() -> void:
	get_tree().create_timer(0.5,false).connect("timeout",queue_free)
