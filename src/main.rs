mod y2014day1;
mod y2014day2;

use clap::Arg;
use clap::Command;
use std::collections::HashMap;
use std::fs;

fn main() {
    let mut functions: HashMap<&str, fn(input: &str) -> i64> = HashMap::new();
    functions.insert("y2014_day1_solve1", y2014day1::part1);
    functions.insert("y2014_day1_solve2", y2014day1::part2);
    functions.insert("y2014_day2_solve1", y2014day2::part1);
    functions.insert("y2014_day2_solve2", y2014day2::part2);

    let matches = Command::new("AOC in ASM")
        .version("0.1.0")
        .about("Solve AOC in ASM")
        .arg(
            Arg::new("day")
                .short('d')
                .default_value("2")
                .long("day")
                .help("aoc day"),
        )
        .arg(
            Arg::new("year")
                .short('y')
                .default_value("2014")
                .long("year")
                .help("aoc year"),
        )
        .arg(
            Arg::new("part")
                .short('p')
                .default_value("1")
                .long("part")
                .help("part"),
        )
        .arg(
            Arg::new("test")
                .short('t')
                .required(false)
                .num_args(0)
                .help("test"),
        )
        .get_matches();

    let y_str: &String = matches.get_one("year").unwrap();
    let d_str: &String = matches.get_one("day").unwrap();
    let part_str: &String = matches.get_one("part").unwrap();

    let fn_name = format!("y{}_day{}_solve{}", y_str, d_str, part_str);
    let input = fs::read_to_string(format!("inputs/{}/day{}/input", y_str, d_str)).expect(&format!("inputs/{}/day{}/input not found", y_str, d_str));

    let f = functions.get(fn_name.as_str()).unwrap();
    println!("answer for day {} part:{}: {}", d_str, part_str, f(input.as_str()));
}
