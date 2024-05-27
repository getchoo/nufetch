#!/usr/bin/env nu

let sys = (sys)

let field_color = (ansi blue_bold)
let reset = (ansi reset)

def make_field [name: string, value: string] {
	$"($field_color)($name)($reset): ($value)"
}

def user_signature [] {
	let user = (whoami)
	let hostname = ($sys | get host.hostname)
	$"($user)@($hostname)"
}

def os_info [] {
	let host = ($sys | get host)
	let info = $"($host.name) \(($host.os_version))"
	make_field "os" $info
}

def host_info [] {
	let machine = (uname | get machine)
	make_field "host" $machine
}

def kernel_info [] {
	let kernel_version = ($sys | get host.kernel_version)
	make_field "kernel" $kernel_version
}

def uptime_info [] {
	let uptime = ($sys | get host.uptime | into string)
	make_field "uptime" $uptime
}

def mem_info [] {
	let mem = ($sys | get mem)
	make_field "memory" $"($mem.available) / ($mem.total)"
}

[
	(user_signature),
	(os_info),
	(host_info),
	(kernel_info),
	(uptime_info),
	(mem_info)
] | to text
