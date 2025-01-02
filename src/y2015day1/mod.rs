use std::time::{Duration, Instant};

#[link(name = "aoc.a")]
extern "C" {
    fn y2015_day1_solve1(s: *const u8, len: usize) -> i64;
    fn y2015_day1_solve2(s: *const u8, len: usize) -> i64;
}

pub fn part1(input: &str) -> (i64, Duration) {
    let input_ptr: *const u8 = input.as_ptr();
    // Get the length of the string
    let len = input.len();
    unsafe {
        let now = Instant::now();
        let r = y2015_day1_solve1(input_ptr, len);
        let elapsed = now.elapsed();
        return (r,elapsed);
    };
}

pub fn part2(input: &str) -> (i64, Duration) {
    let input_ptr: *const u8 = input.as_ptr();
    // Get the length of the string
    let len = input.len();
    unsafe {
        let now = Instant::now();
        let r = y2015_day1_solve2(input_ptr, len);
        let elapsed = now.elapsed();
        return (r,elapsed);
    };
}

#[cfg(test)]
mod tests {
    use super::*;
    const EXAMPLE: &str = "())(()))";

    #[test]
    fn test_part1() {
        let (result,_) = part1(EXAMPLE);
        assert_eq!(result, -2);
    }

    #[test]
    fn test_part2() {
        let (result,_) = part2(EXAMPLE);
        assert_eq!(result, 2);
    }
}
